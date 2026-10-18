--[[
    Pigeon Dice: server-only settings.

    This file only runs on the server and is never sent to players, so it's the place for secrets.
]]

ServerConfig = {}

-- Discord webhook for logging every roll, or '' for none.
-- You can also set it in server.cfg instead, which keeps it out of this file:
--     set pigeon_dice_webhook "https://discord.com/api/webhooks/..."
-- If both are set, server.cfg wins. Discord limits webhooks to about 30 messages a minute, so on a
-- busy server use a dedicated channel.
ServerConfig.Webhook = ''

--- The name shown when a player rolls. By default it's their FiveM name.
--- To show character names, return them from your framework here. For example, with Qbox:
---     local player = exports.qbx_core:GetPlayer(source)
---     if player then return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname end
---@param source number the player's server ID
---@return string
function ServerConfig.GetName(source)
    return GetPlayerName(source)
end
