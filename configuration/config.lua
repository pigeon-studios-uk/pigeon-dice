--[[
    Pigeon Dice: settings.

    Every setting is explained next to it. Settings that must stay secret, such as a Discord
    webhook, live in configuration/server.lua, which is never sent to players.
]]

Config = {}

-- Language file from locales/ to use, such as 'en'.
Config.Locale = 'en'

---------------------------------------------------------------------------
-- Commands

Config.Commands = {
    roll = 'roll',          -- /roll 2d6+3
    help = 'rollhelp',      -- /rollhelp lists everything /roll understands
    aliases = { 'dice' },   -- extra names for /roll. Use {} for none.
}

-- Who can roll. false lets everyone roll. Set an ACE permission name, such as 'pigeon-dice.roll',
-- to limit it, then grant it in server.cfg:  add_ace group.admin pigeon-dice.roll allow
Config.Permission = false

-- Seconds a player must wait between rolls. 0 turns the cooldown off.
Config.Cooldown = 2.0

---------------------------------------------------------------------------
-- What can be rolled

-- What /roll on its own rolls. Any roll that /roll accepts works here, such as '1d20', '2d6' or '1d100'.
Config.DefaultRoll = '1d20'

Config.Limits = {
    maxDice = 20,         -- most dice in one roll, across every part of it (20 allows 20d6 or 10d6+10d4)
    maxSides = 1000,      -- most sides on one die (d2 to d1000)
    maxTerms = 5,         -- most parts in one roll, such as 2d6+1d4+3 (three parts)
    maxRange = 1000000,   -- largest number allowed in a range roll such as 1-500, or as a bonus such as +5
}

-- Turn individual kinds of roll on or off.
Config.Allow = {
    coin = true,          -- /roll coin
    fate = true,          -- /roll fate, /roll 4dF
    range = true,         -- /roll 100, /roll 1-500, /roll between 1 500
    keep = true,          -- /roll 4d6kh3, 4d6dl1 and similar
    advantage = true,     -- /roll adv, /roll dis
}

---------------------------------------------------------------------------
-- How rolls are shown

-- Players within this many metres of the roller see the roll. They must also be in the same
-- routing bucket (instance) as the roller.
Config.Distance = 20.0

Config.Chat = {
    enabled = true,                 -- show rolls in chat to nearby players
    colour = { 167, 139, 250 },     -- RGB colour of roll messages
}

Config.Floating = {
    enabled = true,                 -- show the result above the roller's head
    seconds = 6,                    -- how long it stays
    lineOfSight = true,             -- only show it to players who can see the roller
    font = 4,                       -- GTA font: 0 standard, 4 condensed, 7 Pricedown
    scale = 0.42,                   -- text size at close range
    height = 0.45,                  -- metres above the head
    colour = { 255, 255, 255, 235 },        -- RGBA for normal rolls
    criticalColour = { 120, 230, 120, 255 },-- a natural 20 on a single d20 (or advantage/disadvantage)
    fumbleColour = { 240, 110, 110, 255 },  -- a natural 1
}

-- How the roller is told about mistakes (an invalid roll, the cooldown).
-- 'auto' uses ox_lib notifications if ox_lib is running, otherwise chat.
-- 'ox_lib' or 'chat' to force one.
Config.Notifications = 'auto'

---------------------------------------------------------------------------
-- Logging

-- Print every roll in the server console.
Config.LogToConsole = false

-- Discord logging is set up in configuration/server.lua.
-- Update checks are controlled in server.cfg for every Pigeon Studios resource at once:
--     set pigeon_update_check "on"      (default)  |  "quiet"  |  "off"
