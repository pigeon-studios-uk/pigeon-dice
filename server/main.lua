--[[
    Pigeon Dice: server.

    Every roll happens here, so players can't fake results. The server picks who can see a roll
    (players nearby, in the same routing bucket) and sends it only to them.
]]

local Dice = PigeonDice
local RESOURCE = GetCurrentResourceName()
local EVENT_SHOW = RESOURCE .. ':client:showRoll'

local lastRoll = {}

---------------------------------------------------------------------------
-- Text

local strings = Locales[Config.Locale] or Locales.en
if not Locales[Config.Locale] then
    print(('^3[%s] Config.Locale "%s" has no file in locales/. Using English.^7'):format(RESOURCE, tostring(Config.Locale)))
end

--- Looks up a locale string and fills in {placeholders}.
local function t(key, values)
    local text = strings[key] or Locales.en[key] or key
    return (text:gsub('{(%w+)}', function(name)
        local value = values and values[name]
        if value == nil then return '{' .. name .. '}' end
        return tostring(value)
    end))
end

--- Makes a player's name safe to show in chat, floating text and Discord.
local function cleanName(name)
    name = tostring(name or ''):gsub('%^%d', ''):gsub('[%c<>`@*_~|\\]', ''):gsub('%s+', ' ')
    name = name:match('^%s*(.-)%s*$')
    if name == '' then name = 'Someone' end
    if #name > 32 then name = name:sub(1, 32) end
    return name
end

---------------------------------------------------------------------------
-- Messages to the roller

local function notify(source, message)
    local useOx = Config.Notifications == 'ox_lib'
        or (Config.Notifications ~= 'chat' and GetResourceState('ox_lib') == 'started')

    if useOx then
        TriggerClientEvent('ox_lib:notify', source, {
            title = t('title'),
            description = message,
            type = 'error',
        })
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = { 240, 110, 110 },
            multiline = true,
            args = { t('title'), message },
        })
    end
end

---------------------------------------------------------------------------
-- Who sees a roll

--- Returns the server IDs of players near `source`, or nil if positions aren't available
--- (OneSync off), in which case every client checks the distance itself.
local function nearbyPlayers(source)
    local ped = GetPlayerPed(source)
    if ped == 0 or not DoesEntityExist(ped) then return nil end

    local origin = GetEntityCoords(ped)
    local bucket = GetPlayerRoutingBucket(source)
    local list = {}

    for _, id in ipairs(GetPlayers()) do
        local player = tonumber(id)
        if player == source then
            list[#list + 1] = player
        elseif GetPlayerRoutingBucket(player) == bucket then
            local otherPed = GetPlayerPed(player)
            if otherPed ~= 0 and #(GetEntityCoords(otherPed) - origin) <= Config.Distance then
                list[#list + 1] = player
            end
        end
    end

    return list
end

---------------------------------------------------------------------------
-- Logging

local function webhookUrl()
    local fromConvar = GetConvar('pigeon_dice_webhook', '')
    if fromConvar ~= '' then return fromConvar end
    return ServerConfig.Webhook or ''
end

local function log(source, name, chatText)
    if Config.LogToConsole then
        print(('[%s] %s (ID %d): %s'):format(RESOURCE, name, source, chatText:gsub('^%* ', '')))
    end

    local url = webhookUrl()
    if url == '' then return end

    PerformHttpRequest(url, function(status)
        if status < 200 or status >= 300 then
            print(('^3[%s] Discord webhook failed (HTTP %s). Check the webhook URL.^7'):format(RESOURCE, tostring(status)))
        end
    end, 'POST', json.encode({
        username = 'Pigeon Dice',
        allowed_mentions = { parse = {} },
        embeds = { {
            description = ('**%s** (ID %d)\n%s'):format(name, source, chatText:gsub('^%* ', '')),
            color = 0xA78BFA,
            timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        } },
    }), { ['Content-Type'] = 'application/json' })
end

---------------------------------------------------------------------------
-- Rolling

local limits = {
    default = Config.DefaultRoll,
    maxDice = Config.Limits.maxDice,
    maxSides = Config.Limits.maxSides,
    maxTerms = Config.Limits.maxTerms,
    maxRange = Config.Limits.maxRange,
    allow = Config.Allow,
}

--- Builds the chat and floating text for a result.
local function describe(name, result, request)
    if result.kind == 'coin' then
        local side = t(result.heads and 'heads' or 'tails')
        return t('chat_coin', { name = name, result = side }), t('float_coin', { result = side })
    end

    if result.kind == 'range' then
        local values = { name = name, low = request.low, high = request.high, total = result.total }
        return t('chat_range', values), t('float_range', values)
    end

    local chat = t('chat_roll', { name = name, label = result.label, total = result.total, detail = result.detail or '' })
    chat = chat:gsub('%s+$', '')
    if result.natural == 'critical' then
        chat = chat .. t('chat_critical')
    elseif result.natural == 'fumble' then
        chat = chat .. t('chat_fumble')
    end
    return chat, t('float_roll', { label = result.label, total = result.total })
end

--- Rolls without showing anything. Returns the result, or nil and an error message.
local function roll(input)
    local request, errorKey, values = Dice.parse(input, limits)
    if not request then
        values = values or {}
        values.help = Config.Commands.help
        return nil, t('error_' .. errorKey, values)
    end
    return Dice.roll(request), nil, request
end

--- Rolls for a player and shows it to everyone nearby. Returns the result, or nil and an error message.
local function rollFor(source, input)
    local result, problem, request = roll(input)
    if not result then return nil, problem end

    local name = cleanName(ServerConfig.GetName(source))
    local chatText, floatText = describe(name, result, request)
    local payload = {
        source = source,
        chat = chatText,
        float = floatText,
        natural = result.natural,
    }

    local recipients = nearbyPlayers(source)
    if recipients then
        for _, player in ipairs(recipients) do
            TriggerClientEvent(EVENT_SHOW, player, payload)
        end
    else
        payload.checkDistance = true
        TriggerClientEvent(EVENT_SHOW, -1, payload)
    end

    log(source, name, chatText)
    return result
end

---------------------------------------------------------------------------
-- Commands

local function onRoll(source, args)
    if source == 0 then
        print(('[%s] /%s is for players. To test from the console, use: %s_test 2d6+3'):format(RESOURCE, Config.Commands.roll, RESOURCE))
        return
    end

    if Config.Permission and not IsPlayerAceAllowed(source, Config.Permission) then
        return notify(source, t('error_permission'))
    end

    local now = GetGameTimer()
    local cooldownMs = math.floor((Config.Cooldown or 0) * 1000)
    if cooldownMs > 0 and lastRoll[source] and now - lastRoll[source] < cooldownMs then
        return notify(source, t('error_cooldown'))
    end

    local _, problem = rollFor(source, table.concat(args, ' '))
    if problem then
        return notify(source, problem)
    end
    lastRoll[source] = now
end

RegisterCommand(Config.Commands.roll, onRoll, false)
for _, alias in ipairs(Config.Commands.aliases or {}) do
    RegisterCommand(alias, onRoll, false)
end

RegisterCommand(Config.Commands.help, function(source)
    if source == 0 then return end

    local values = {
        roll = Config.Commands.roll,
        default = Config.DefaultRoll,
        terms = Config.Limits.maxTerms,
        distance = math.floor(Config.Distance),
    }
    local allow = Config.Allow
    local lines = {
        { 'help_title' }, { 'help_default' }, { 'help_dice' }, { 'help_math' }, { 'help_percentile' },
        { 'help_keep', allow.keep }, { 'help_advantage', allow.advantage }, { 'help_fate', allow.fate },
        { 'help_coin', allow.coin }, { 'help_range', allow.range }, { 'help_footer' },
    }

    for i, line in ipairs(lines) do
        if line[2] ~= false then
            TriggerClientEvent('chat:addMessage', source, {
                color = i == 1 and Config.Chat.colour or { 220, 220, 220 },
                multiline = true,
                args = { t(line[1], values) },
            })
        end
    end
end, false)

-- Console-only command for checking rolls and settings without joining the server.
RegisterCommand(RESOURCE .. '_test', function(source, args)
    if source ~= 0 then return end
    local result, problem, request = roll(table.concat(args, ' '))
    if not result then
        print(('[%s] %s'):format(RESOURCE, problem))
        return
    end
    local chatText = describe('Console', result, request)
    print(('[%s] %s'):format(RESOURCE, chatText))
end, true)

AddEventHandler('playerDropped', function()
    lastRoll[source] = nil
end)

---------------------------------------------------------------------------
-- Exports for other resources

--- Rolls without showing it to anyone.
--- exports['pigeon-dice']:Roll('2d6+3') -> { kind, label, total, detail, natural } or nil, errorMessage
exports('Roll', function(input)
    local result, problem = roll(input)
    return result, problem
end)

--- Rolls for a player and shows it to everyone nearby, as if they used /roll (no cooldown or permission check).
--- exports['pigeon-dice']:RollFor(source, '1d20') -> result or nil, errorMessage
exports('RollFor', function(source, input)
    source = tonumber(source)
    if not source or GetPlayerName(source) == nil then return nil, 'Unknown player' end
    return rollFor(source, input)
end)
