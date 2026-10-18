--[[
    Pigeon Dice: client.

    Shows rolls the server sends: in chat, and as floating text above the roller's head.
    The client never rolls anything itself.
]]

local RESOURCE = GetCurrentResourceName()
local HEAD_BONE = 31086          -- SKEL_Head
local LOS_FLAGS = 17             -- world and objects, the usual flags for line-of-sight checks
local LOS_INTERVAL_MS = 250      -- how often line of sight is re-checked for each floating roll
local MAX_FLOATING = 16          -- SetDrawOrigin allows 32 origins a frame; stay well under

local strings = Locales[Config.Locale] or Locales.en
local floating = {}              -- [serverId] = { text, colour, expires, visible, nextLos }
local drawing = false

---------------------------------------------------------------------------
-- Floating text

local function drawText3d(coords, text, colour, scale)
    SetDrawOrigin(coords.x, coords.y, coords.z, false)
    SetTextScale(0.0, scale)
    SetTextFont(Config.Floating.font)
    SetTextColour(colour[1], colour[2], colour[3], colour[4] or 255)
    SetTextCentre(true)
    SetTextOutline()
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

local function startDrawing()
    if drawing then return end
    drawing = true

    CreateThread(function()
        while next(floating) do
            local now = GetGameTimer()
            local myPed = PlayerPedId()
            local myCoords = GetEntityCoords(myPed)
            local camera = GetFinalRenderedCamCoord()

            for serverId, entry in pairs(floating) do
                local player = GetPlayerFromServerId(serverId)
                local ped = player ~= -1 and GetPlayerPed(player) or 0

                if now >= entry.expires or ped == 0 or not DoesEntityExist(ped) then
                    floating[serverId] = nil
                else
                    local head = GetPedBoneCoords(ped, HEAD_BONE, 0.0, 0.0, 0.0)
                    local position = vector3(head.x, head.y, head.z + Config.Floating.height)

                    if #(position - myCoords) <= Config.Distance then
                        if Config.Floating.lineOfSight and ped ~= myPed and now >= entry.nextLos then
                            entry.visible = HasEntityClearLosToEntity(myPed, ped, LOS_FLAGS)
                            entry.nextLos = now + LOS_INTERVAL_MS
                        end

                        if entry.visible then
                            -- Shrink with distance from the camera so far-away text doesn't dominate the screen.
                            local distance = #(position - camera)
                            local scale = Config.Floating.scale * math.max(0.55, math.min(1.0, 6.0 / math.max(distance, 0.1)))
                            drawText3d(position, entry.text, entry.colour, scale)
                        end
                    end
                end
            end

            Wait(0)
        end
        drawing = false
    end)
end

local function addFloating(serverId, text, natural)
    if not floating[serverId] then
        local count = 0
        for _ in pairs(floating) do count = count + 1 end
        if count >= MAX_FLOATING then return end
    end

    local colour = Config.Floating.colour
    if natural == 'critical' then
        colour = Config.Floating.criticalColour
    elseif natural == 'fumble' then
        colour = Config.Floating.fumbleColour
    end

    -- A new roll from the same player replaces their last one.
    floating[serverId] = {
        text = text,
        colour = colour,
        expires = GetGameTimer() + math.floor(Config.Floating.seconds * 1000),
        visible = true,
        nextLos = 0,
    }
    startDrawing()
end

---------------------------------------------------------------------------
-- Rolls from the server

--- True if the roller is close enough to this player. Only used when the server couldn't check (OneSync off).
local function isNearby(serverId)
    if serverId == GetPlayerServerId(PlayerId()) then return true end
    local player = GetPlayerFromServerId(serverId)
    if player == -1 then return false end
    local ped = GetPlayerPed(player)
    if ped == 0 or not DoesEntityExist(ped) then return false end
    return #(GetEntityCoords(ped) - GetEntityCoords(PlayerPedId())) <= Config.Distance
end

RegisterNetEvent(RESOURCE .. ':client:showRoll', function(roll)
    if type(roll) ~= 'table' or type(roll.source) ~= 'number' then return end
    if roll.checkDistance and not isNearby(roll.source) then return end

    if Config.Chat.enabled and type(roll.chat) == 'string' then
        TriggerEvent('chat:addMessage', {
            color = Config.Chat.colour,
            multiline = true,
            args = { roll.chat },
        })
    end

    if Config.Floating.enabled and type(roll.float) == 'string' then
        addFloating(roll.source, roll.float, roll.natural)
    end
end)

---------------------------------------------------------------------------
-- Chat suggestions

local function fill(text)
    return (text:gsub('{roll}', Config.Commands.roll))
end

CreateThread(function()
    local rollHelp = {
        { name = strings.suggest_roll_param or 'roll', help = strings.suggest_roll_param_help or '' },
    }

    TriggerEvent('chat:addSuggestion', '/' .. Config.Commands.roll, strings.suggest_roll or '', rollHelp)
    for _, alias in ipairs(Config.Commands.aliases or {}) do
        TriggerEvent('chat:addSuggestion', '/' .. alias, strings.suggest_roll or '', rollHelp)
    end
    TriggerEvent('chat:addSuggestion', '/' .. Config.Commands.help, fill(strings.suggest_help or ''), {})
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= RESOURCE then return end
    TriggerEvent('chat:removeSuggestion', '/' .. Config.Commands.roll)
    for _, alias in ipairs(Config.Commands.aliases or {}) do
        TriggerEvent('chat:removeSuggestion', '/' .. alias)
    end
    TriggerEvent('chat:removeSuggestion', '/' .. Config.Commands.help)
end)
