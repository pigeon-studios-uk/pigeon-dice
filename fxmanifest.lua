fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'pigeon-dice'
author 'Pigeon Studios'
description 'Roleplay dice for FiveM: roll anything from a d20 to 2d6+3, advantage, Fate dice, coins and ranges, shown in chat and above your head.'
version '2.0.0'
repository 'https://github.com/WelshPigeon/pigeon-dice'

-- Pigeon Studios version registry entry, read by server/version_check.lua.
pigeon_slug 'pigeon-dice'

shared_scripts {
    'configuration/config.lua',
    'locales/*.lua',
}

server_scripts {
    'configuration/server.lua',
    'server/dice.lua',
    'server/main.lua',
    'server/version_check.lua',
}

client_scripts {
    'client/main.lua',
}
