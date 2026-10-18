--[[
    Tests for server/main.lua and client/main.lua.

    Loads the real resource files in plain Lua 5.4 with a small simulation of FiveM: players with
    positions and routing buckets, commands, events, chat and exports. Then checks who sees each roll
    and what they see.

    Run from the repository root:
        lua tests/resource.test.lua
]]

local passed, failed = 0, 0
local function check(name, ok, detail)
    if ok then
        passed = passed + 1
    else
        failed = failed + 1
        io.write(('  \27[31mFAIL\27[0m  %s%s\n'):format(name, detail and ('\n          ' .. tostring(detail)) or ''))
    end
end

---------------------------------------------------------------------------
-- vector3

local vmeta = {}
vmeta.__index = vmeta
vmeta.__sub = function(a, b) return setmetatable({ x = a.x - b.x, y = a.y - b.y, z = a.z - b.z }, vmeta) end
vmeta.__len = function(a) return math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z) end
function vector3(x, y, z) return setmetatable({ x = x, y = y, z = z }, vmeta) end

---------------------------------------------------------------------------
-- Simulated server

local function newWorld(options)
    options = options or {}
    local world = {
        players = {},        -- [id] = { name, pos, bucket, aces }
        commands = {},
        handlers = {},       -- server event handlers
        sent = {},           -- { target, event, payload }
        exports = {},
        printed = {},
        http = {},
        now = 100000,
        resources = options.resources or {},
        convars = options.convars or {},
        onesync = options.onesync ~= false,
    }

    local env = setmetatable({}, { __index = _G })
    env.vector3 = vector3
    env.GetCurrentResourceName = function() return 'pigeon-dice' end
    env.GetResourceState = function(name) return world.resources[name] or 'missing' end
    env.GetConvar = function(name, default) return world.convars[name] or default end
    env.GetGameTimer = function() return world.now end
    env.GetPlayers = function()
        local list = {}
        for id in pairs(world.players) do list[#list + 1] = tostring(id) end
        table.sort(list)
        return list
    end
    env.GetPlayerName = function(id) local p = world.players[tonumber(id)]; return p and p.name or nil end
    env.GetPlayerPed = function(id)
        if not world.onesync then return 0 end
        return world.players[tonumber(id)] and (1000 + tonumber(id)) or 0
    end
    env.DoesEntityExist = function(ped) return ped ~= 0 end
    env.GetEntityCoords = function(ped) return world.players[ped - 1000].pos end
    env.GetPlayerRoutingBucket = function(id) return world.players[tonumber(id)].bucket or 0 end
    env.IsPlayerAceAllowed = function(id, ace) return world.players[tonumber(id)].aces and world.players[tonumber(id)].aces[ace] or false end
    env.RegisterCommand = function(name, fn) world.commands[name] = fn end
    env.TriggerClientEvent = function(event, target, payload) world.sent[#world.sent + 1] = { target = target, event = event, payload = payload } end
    env.AddEventHandler = function(event, fn) world.handlers[event] = fn end
    env.exports = function(name, fn) world.exports[name] = fn end
    env.PerformHttpRequest = function(url, cb, method, body, headers) world.http[#world.http + 1] = { url = url, method = method, body = body, headers = headers } end
    env.json = { encode = function(v) return 'JSON' end }
    env.print = function(text) world.printed[#world.printed + 1] = text end
    env.Locales = nil

    world.env = env
    for _, file in ipairs({ 'configuration/config.lua', 'locales/en.lua', 'configuration/server.lua', 'server/dice.lua', 'server/main.lua' }) do
        local chunk = assert(loadfile(file, 't', env))
        chunk()
    end
    if options.configure then options.configure(env.Config) end
    return world
end

local function addPlayer(world, id, name, x, y, bucket)
    world.players[id] = { name = name, pos = vector3(x, y, 0), bucket = bucket or 0 }
end

local function run(world, source, command, args)
    world.sent = {}
    world.source = source
    world.commands[command](source, args or {}, '')
    return world.sent
end

local function targets(sent, event)
    local list = {}
    for _, s in ipairs(sent) do if s.event == event then list[#list + 1] = s.target end end
    table.sort(list, function(a, b) return a < b end)
    return table.concat(list, ',')
end

local SHOW = 'pigeon-dice:client:showRoll'

io.write('Pigeon Dice resource tests\n')

---------------------------------------------------------------------------
-- Server: who sees a roll

do
    local world = newWorld()
    addPlayer(world, 1, 'Roller', 0, 0)
    addPlayer(world, 2, 'Near', 10, 0)
    addPlayer(world, 3, 'Edge', 20, 0)
    addPlayer(world, 4, 'Far', 25, 0)
    addPlayer(world, 5, 'OtherInstance', 1, 0, 7)

    local sent = run(world, 1, 'roll', { '2d6+3' })
    check('roll goes to the roller and players within 20 m in the same bucket', targets(sent, SHOW) == '1,2,3', targets(sent, SHOW))

    local payload = sent[1].payload
    check('payload says who rolled', payload.source == 1)
    check('chat text names the roller and the roll', payload.chat:find('^%* Roller rolls 2d6%+3: %d+  %[%d, %d%] %+ 3$') ~= nil, payload.chat)
    check('floating text is short', payload.float:find('^2d6%+3: %d+$') ~= nil, payload.float)
    check('no client-side distance check needed with OneSync', payload.checkDistance == nil)

    -- Everyone receives the same roll.
    local same = true
    for _, s in ipairs(sent) do if s.payload.chat ~= payload.chat then same = false end end
    check('every recipient gets the identical result', same)
end

do
    local world = newWorld({ onesync = false })
    addPlayer(world, 1, 'Roller', 0, 0)
    addPlayer(world, 2, 'Other', 500, 0)
    local sent = run(world, 1, 'roll', { 'd20' })
    check('without OneSync, sent to everyone (-1) with a client distance check', #sent == 1 and sent[1].target == -1 and sent[1].payload.checkDistance == true)
end

---------------------------------------------------------------------------
-- Server: cooldown, permission, errors

do
    local world = newWorld()
    addPlayer(world, 1, 'Roller', 0, 0)
    run(world, 1, 'roll', { 'd20' })
    world.now = world.now + 500
    local sent = run(world, 1, 'roll', { 'd20' })
    check('second roll within 2 s is refused', targets(sent, SHOW) == '' and sent[1].event == 'chat:addMessage' and sent[1].payload.args[2]:find('Wait') ~= nil)
    world.now = world.now + 2000
    sent = run(world, 1, 'roll', { 'd20' })
    check('roll allowed again after the cooldown', targets(sent, SHOW) == '1')
end

do
    local world = newWorld()
    addPlayer(world, 1, 'Roller', 0, 0)
    run(world, 1, 'roll', { 'banana' })
    local sent = run(world, 1, 'roll', { 'd20' })
    check('an invalid roll doesn\'t start the cooldown', targets(sent, SHOW) == '1')
end

do
    local world = newWorld({ resources = { ox_lib = 'started' } })
    addPlayer(world, 1, 'Roller', 0, 0)
    local sent = run(world, 1, 'roll', { 'banana' })
    check('errors use ox_lib notifications when ox_lib is running', sent[1].event == 'ox_lib:notify' and sent[1].target == 1 and sent[1].payload.description:find('/rollhelp') ~= nil, sent[1] and sent[1].event)
end

do
    local world = newWorld()
    addPlayer(world, 1, 'Roller', 0, 0)
    local sent = run(world, 1, 'roll', { '50d6' })
    check('errors fall back to chat, only to the roller', #sent == 1 and sent[1].event == 'chat:addMessage' and sent[1].target == 1 and sent[1].payload.args[2]:find('up to 20 dice') ~= nil)
end

do
    local world = newWorld({ configure = function(c) c.Permission = 'pigeon-dice.roll' end })
    addPlayer(world, 1, 'Roller', 0, 0)
    local sent = run(world, 1, 'roll', { 'd20' })
    check('permission required: refused without the ACE', targets(sent, SHOW) == '' and sent[1].payload.args[2]:find('permission') ~= nil)
    world.players[1].aces = { ['pigeon-dice.roll'] = true }
    sent = run(world, 1, 'roll', { 'd20' })
    check('permission required: allowed with the ACE', targets(sent, SHOW) == '1')
end

do
    local world = newWorld()
    addPlayer(world, 1, 'Roller', 0, 0)
    check('aliases are registered', world.commands.dice ~= nil)
    local sent = run(world, 1, 'dice', { 'coin' })
    check('coin flip text', sent[1].payload.chat:find('^%* Roller flips a coin: [HT]') ~= nil and sent[1].payload.float:find('^Coin: ') ~= nil, sent[1].payload.chat)
    world.now = world.now + 5000
    sent = run(world, 1, 'roll', { '1-500' })
    check('range text', sent[1].payload.chat:find('^%* Roller picks a number from 1 to 500: %d+$') ~= nil, sent[1].payload.chat)
end

---------------------------------------------------------------------------
-- Server: names, help, logging, exports, console

do
    local world = newWorld()
    addPlayer(world, 1, '^1<img src=x>Evil`@everyone', 0, 0)
    local sent = run(world, 1, 'roll', { 'd20' })
    local chat = sent[1].payload.chat
    check('player names are cleaned of colour codes, HTML and Discord mentions', not chat:find('[<>^`@]'), chat)
end

do
    local world = newWorld()
    addPlayer(world, 1, 'Roller', 0, 0)
    world.env.Config.Allow.fate = false
    local sent = run(world, 1, 'rollhelp')
    local text = {}
    for _, s in ipairs(sent) do text[#text + 1] = s.payload.args[1] end
    text = table.concat(text, '\n')
    check('/rollhelp lists rolls and fills in placeholders', text:find('/roll 2d6%+3') ~= nil and not text:find('{'), text)
    check('/rollhelp hides turned-off roll types', not text:find('Fate'), text)
end

do
    local world = newWorld({ convars = { pigeon_dice_webhook = 'https://discord.com/api/webhooks/1/abc' } })
    addPlayer(world, 1, 'Roller', 0, 0)
    run(world, 1, 'roll', { 'd20' })
    check('webhook from server.cfg is used', #world.http == 1 and world.http[1].method == 'POST' and world.http[1].url:find('discord') ~= nil)
    local world2 = newWorld()
    addPlayer(world2, 1, 'Roller', 0, 0)
    run(world2, 1, 'roll', { 'd20' })
    check('no webhook, no request', #world2.http == 0)
end

do
    local world = newWorld()
    addPlayer(world, 1, 'Roller', 0, 0)
    addPlayer(world, 2, 'Near', 5, 0)
    local result, problem = world.exports.Roll('3d6')
    check('Roll export returns a result without showing it', result and result.total >= 3 and result.total <= 18 and problem == nil and #world.sent == 0)
    result, problem = world.exports.Roll('nonsense')
    check('Roll export returns an error message for bad input', result == nil and type(problem) == 'string')
    world.sent = {}
    result = world.exports.RollFor(2, 'd20')
    check('RollFor export shows the roll around that player', result and targets(world.sent, SHOW) == '1,2')
    check('RollFor rejects unknown players', world.exports.RollFor(99, 'd20') == nil)
end

do
    local world = newWorld()
    world.printed = {}
    world.commands['pigeon-dice_test'](0, { '2d6+3' })
    check('console test command prints a roll', world.printed[1] and world.printed[1]:find('Console rolls 2d6%+3') ~= nil, world.printed[1])
    world.printed = {}
    world.commands.roll(0, {})
    check('/roll from the console explains itself instead of erroring', world.printed[1] and world.printed[1]:find('_test') ~= nil)
end

do
    local world = newWorld()
    addPlayer(world, 1, 'Roller', 0, 0)
    run(world, 1, 'roll', { 'd20' })
    world.env.source = 1
    world.handlers.playerDropped()
    world.now = world.now + 1
    local sent = run(world, 1, 'roll', { 'd20' })
    check('cooldown is cleared when a player leaves', targets(sent, SHOW) == '1')
end

---------------------------------------------------------------------------
-- Client

local function newClient(me, others)
    local client = { chat = {}, suggestions = {}, threads = {}, drawn = {}, events = {}, now = 0 }
    local env = setmetatable({}, { __index = _G })
    local peds = { [me.id] = 500 + me.id }
    local pos = { [500 + me.id] = me.pos }
    for _, o in ipairs(others) do peds[o.id] = 500 + o.id; pos[500 + o.id] = o.pos end

    env.vector3 = vector3
    env.GetCurrentResourceName = function() return 'pigeon-dice' end
    env.GetGameTimer = function() return client.now end
    env.PlayerPedId = function() return peds[me.id] end
    env.PlayerId = function() return me.id end
    env.GetPlayerServerId = function(player) return player end
    env.GetPlayerFromServerId = function(id) return peds[id] and id or -1 end
    env.GetPlayerPed = function(player) return peds[player] or 0 end
    env.DoesEntityExist = function(ped) return pos[ped] ~= nil end
    env.GetEntityCoords = function(ped) return pos[ped] end
    env.GetPedBoneCoords = function(ped) local p = pos[ped]; return vector3(p.x, p.y, p.z + 0.7) end
    env.GetFinalRenderedCamCoord = function() return me.pos end
    env.HasEntityClearLosToEntity = function() return client.los ~= false end
    for _, name in ipairs({ 'SetDrawOrigin', 'ClearDrawOrigin', 'SetTextScale', 'SetTextFont', 'SetTextColour', 'SetTextCentre', 'SetTextOutline', 'BeginTextCommandDisplayText', 'EndTextCommandDisplayText' }) do
        env[name] = function() end
    end
    env.AddTextComponentSubstringPlayerName = function(text) client.drawn[#client.drawn + 1] = text end
    env.CreateThread = function(fn) client.threads[#client.threads + 1] = coroutine.create(fn) end
    env.Wait = function() coroutine.yield() end
    env.RegisterNetEvent = function(name, fn) client.events[name] = fn end
    env.AddEventHandler = function(name, fn) client.events[name] = fn end
    env.TriggerEvent = function(name, a, b, c)
        if name == 'chat:addMessage' then client.chat[#client.chat + 1] = a
        elseif name == 'chat:addSuggestion' then client.suggestions[a] = b end
    end

    for _, file in ipairs({ 'configuration/config.lua', 'locales/en.lua', 'client/main.lua' }) do
        assert(loadfile(file, 't', env))()
    end

    function client.tick()
        client.drawn = {}
        for i = #client.threads, 1, -1 do
            local co = client.threads[i]
            if coroutine.status(co) ~= 'dead' then
                local ok, err = coroutine.resume(co)
                if not ok then error(err) end
            end
            if coroutine.status(co) == 'dead' then table.remove(client.threads, i) end
        end
    end
    client.env = env
    return client
end

do
    local client = newClient({ id = 2, pos = vector3(5, 0, 0) }, { { id = 1, pos = vector3(0, 0, 0) } })
    client.tick()
    check('chat suggestions are added for /roll, aliases and /rollhelp', client.suggestions['/roll'] and client.suggestions['/dice'] and client.suggestions['/rollhelp'] and client.suggestions['/rollhelp']:find('/roll') ~= nil)

    client.events['pigeon-dice:client:showRoll']({ source = 1, chat = '* Roller rolls 1d20: 12  [12]', float = '1d20: 12' })
    check('roll appears in chat', #client.chat == 1 and client.chat[1].args[1]:find('Roller rolls') ~= nil)
    client.tick()
    check('roll floats above the roller', client.drawn[1] == '1d20: 12', tostring(client.drawn[1]))

    client.events['pigeon-dice:client:showRoll']({ source = 1, chat = 'x', float = '2d6: 7' })
    client.tick()
    check('a new roll replaces the same player\'s floating text', #client.drawn == 1 and client.drawn[1] == '2d6: 7')

    client.now = 7000
    client.tick()
    check('floating text disappears after the configured time', #client.drawn == 0)
    client.tick()
    check('the draw loop stops when nothing is floating', #client.threads == 0)
end

do
    local client = newClient({ id = 2, pos = vector3(5, 0, 0) }, { { id = 1, pos = vector3(0, 0, 0) } })
    client.los = false
    client.events['pigeon-dice:client:showRoll']({ source = 1, chat = 'x', float = '1d20: 3' })
    client.tick()
    check('floating text is hidden without line of sight', #client.drawn == 0)
end

do
    local client = newClient({ id = 2, pos = vector3(500, 0, 0) }, { { id = 1, pos = vector3(0, 0, 0) } })
    client.events['pigeon-dice:client:showRoll']({ source = 1, chat = 'x', float = 'y', checkDistance = true })
    check('without OneSync, far-away rolls are ignored by the client', #client.chat == 0)
    client.events['pigeon-dice:client:showRoll']({ source = 2, chat = 'mine', float = 'y', checkDistance = true })
    check('without OneSync, your own roll always shows', #client.chat == 1)
    client.events['pigeon-dice:client:showRoll']('garbage')
    check('malformed events are ignored', #client.chat == 1)
end

io.write(('%d passed, %d failed\n'):format(passed, failed))
os.exit(failed == 0 and 0 or 1)
