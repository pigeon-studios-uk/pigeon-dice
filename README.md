<div align="center">
  <h1>Pigeon Dice</h1>

  <p><strong>Roleplay dice for FiveM: roll anything from a d20 to 2d6+3, advantage, Fate dice, coins and ranges, shown in chat and above your head.</strong></p>

  <p>
    <a href="https://github.com/WelshPigeon/pigeon-dice/releases/latest"><img src="https://img.shields.io/github/v/release/WelshPigeon/pigeon-dice?label=release&color=2ea043" alt="Latest release" /></a>
    <a href="LICENSE.md"><img src="https://img.shields.io/badge/licence-Pigeon%20Studios%20Free-6f42c1" alt="Licence: Pigeon Studios Free Licence" /></a>
    <a href="https://discord.gg/2NFVWEUmDF"><img src="https://img.shields.io/badge/support-Discord-5865F2?logo=discord&logoColor=white" alt="Discord support" /></a>
    <img src="https://img.shields.io/badge/FiveM-resource-F40552" alt="FiveM resource" />
  </p>

  <p>
    <a href="https://github.com/WelshPigeon/pigeon-dice/releases/latest"><strong>Download</strong></a> ·
    <a href="#installation">Install</a> ·
    <a href="#configuration">Configure</a> ·
    <a href="CHANGELOG.md">Changelog</a> ·
    <a href="https://discord.gg/2NFVWEUmDF">Support</a>
  </p>
</div>

---

## Contents

- [Overview](#overview)
- [Features](#features)
- [What players see](#what-players-see)
- [Requirements](#requirements)
- [Installation](#installation)
- [Updating](#updating)
- [Commands](#commands)
- [What /roll understands](#what-roll-understands)
- [Configuration](#configuration)
- [Permissions](#permissions)
- [Character names](#character-names)
- [Discord logging](#discord-logging)
- [Exports](#exports)
- [Localisation](#localisation)
- [Update checker](#update-checker)
- [Performance](#performance)
- [Security](#security)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)
- [Support](#support)
- [Contributing](#contributing)
- [Licence](#licence)
- [Credits](#credits)

## Overview

Pigeon Dice is a free dice roller for roleplay servers by [Pigeon Studios](https://pigeonstudios.co.uk). Players type `/roll` with anything from a plain d20 to `4d6kh3` or `2d6+1d4+3`, and everyone nearby sees the result in chat and floating above the roller's head.

Every roll happens on the server, so results can't be faked, and only players close enough to see the roller are sent it. It works on its own with no framework or other resources, and uses ox_lib notifications if you have it.

## Features

- **Real dice notation.** Any number of dice with up to 1000 sides, added together with bonuses and penalties (`2d6+1d4-1`), percentile dice (`d%`), and keep or drop the highest or lowest (`4d6kh3`, `4d6dl1`).
- **Roleplay shortcuts.** Advantage and disadvantage (`adv`, `dis`), Fate dice (`fate`, `4dF`), coin flips, and number ranges (`100`, `5-50`).
- **Shown where it makes sense.** In chat to players nearby, and as floating text above the roller's head that only shows to players who can actually see them.
- **Crits and fumbles.** A natural 20 floats in green and a natural 1 in red, on a single d20 and on advantage or disadvantage.
- **Fair and private.** The server rolls every die, picks who's close enough (in the same routing bucket), and sends the roll only to them.
- **Spam-proof.** A per-player cooldown, limits on dice, sides and parts, and nothing a player types is ever run as a command.
- **Standalone.** No framework needed. ox_lib notifications are used automatically if ox_lib is running.
- **Optional extras.** ACE permissions, character names from your framework, Discord and console logging, and exports for other resources.
- **Translatable.** Every message players see is in `locales/`.
- **Lightweight.** Nothing runs until someone rolls. Floating text draws only while it's showing.

## What players see

In chat, to everyone within 20 metres:

```text
* Pigeon rolls 4d6kh3: 15  [(1), 6, 4, 5]
* Pigeon rolls 2d20kh1: 20  [(7), 20] (natural 20!)
* Pigeon rolls 2d6+1d4+3: 19  [6, 6] + [4] + 3
* Pigeon rolls 4dF: 1  [+, -, 0, +]
* Pigeon flips a coin: Heads
* Pigeon picks a number from 1 to 500: 342
```

Dropped dice are shown in brackets. Above the roller's head, for six seconds: `4d6kh3: 15`.

## Requirements

| Requirement | Version | Notes |
|---|---|---|
| FXServer | A [recommended artifact](https://runtime.fivem.net/artifacts/) | |
| OneSync | Recommended | The server uses player positions to send rolls only to players nearby. Without OneSync, every player receives each roll and their game ignores rolls that are too far away |
| Chat | Any resource that handles `chat:addMessage` | The default `chat` resource is fine |
| [ox_lib](https://github.com/communityox/ox_lib) | Optional | Used for error notifications if it's running |

**Frameworks:** none needed. It works the same on standalone servers, ESX Legacy, QBCore, Qbox and ox_core. To show character names instead of FiveM names, see [Character names](#character-names).

## Installation

1. **Download** `pigeon-dice.zip` from the [latest release](https://github.com/WelshPigeon/pigeon-dice/releases/latest). Don't use the green **Code** button; release zips are the tested builds.
2. **Extract** it into your server's `resources` folder. The folder must be called `pigeon-dice`.
3. **Start it** by adding this to `server.cfg`, after your chat resource (and after ox_lib, if you use it):

   ```cfg
   ensure pigeon-dice
   ```

4. **Configure** it in `configuration/config.lua` if you want to change anything. The defaults work as they are.
5. **Restart** your server. The console shows one line from the update checker:

   ```text
   [Pigeon Studios] Pigeon Dice v2.0.0 is up to date.
   ```

Check it's working from the server console without joining:

```text
pigeon-dice_test 2d6+3
```

## Updating

1. Read the [changelog](CHANGELOG.md) for every version between yours and the latest, especially any **Upgrade notes**.
2. Back up your `configuration/` and `locales/` folders.
3. Replace the `pigeon-dice` folder with the new release.
4. Copy your changed settings into the new `configuration/config.lua` and `configuration/server.lua`. Don't copy the old files over the new ones; new versions can add settings.
5. Restart the resource.

**Upgrading from version 1.x:** version 2 is a rewrite. Replace the folder completely, set up `configuration/config.lua` again, and remove any `ensure ox_lib` you added only for Pigeon Dice if nothing else needs it. Version 2 no longer needs ox_lib, doesn't rely on a `/do` command, and uses new event names.

## Commands

| Command | Who can use it | What it does |
|---|---|---|
| `/roll [roll]` | Everyone, or players with the ACE in `Config.Permission` | Rolls and shows the result to everyone nearby. On its own, rolls `Config.DefaultRoll` (a d20) |
| `/dice [roll]` | Same as `/roll` | An alias. Change or remove aliases in `Config.Commands.aliases` |
| `/rollhelp` | Everyone | Lists everything `/roll` understands, in chat |
| `pigeon-dice_test [roll]` | Server console only | Rolls and prints the result, to check settings without joining |

All command names can be changed in `Config.Commands`.

## What /roll understands

Spaces and capital letters don't matter.

| Type this | To roll | Example result |
|---|---|---|
| `/roll` | The default, `1d20` | `1d20: 14  [14]` |
| `/roll d20`, `/roll 3d6` | Dice: `[count]d<sides>`, 2 to 1000 sides | `3d6: 13  [2, 5, 6]` |
| `/roll 2d6+3`, `/roll 1d20-2` | Dice with a bonus or penalty | `2d6+3: 12  [4, 5] + 3` |
| `/roll 2d6+1d4+3` | Several parts added or subtracted (up to 5) | `2d6+1d4+3: 19  [6, 6] + [4] + 3` |
| `/roll d%` | A percentile die (1 to 100) | `1d100: 73  [73]` |
| `/roll 4d6kh3` (or `4d6k3`) | Keep the highest 3 | `4d6kh3: 15  [(1), 6, 4, 5]` |
| `/roll 4d6kl1` | Keep the lowest 1 | `4d6kl1: 2  [(3), (3), 2, (6)]` |
| `/roll 4d6dl1` | Drop the lowest 1 | `4d6dl1: 12  [3, 3, (2), 6]` |
| `/roll 4d6dh1` | Drop the highest 1 | `4d6dh1: 9  [6, (6), 2, 1]` |
| `/roll adv` | Advantage: 2d20, keep the highest | `2d20kh1: 20  [(7), 20] (natural 20!)` |
| `/roll dis` | Disadvantage: 2d20, keep the lowest | `2d20kl1: 1  [1, (15)] (natural 1)` |
| `/roll fate`, `/roll 4dF` | Fate (Fudge) dice: each is -, 0 or + | `4dF: 1  [+, -, 0, +]` |
| `/roll coin` (or `flip`) | Heads or tails | `Heads` |
| `/roll 100` | A number from 1 to 100 | `1 to 100: 42` |
| `/roll 5-50`, `/roll between 5 50` | A number in a range; negatives work too (`-10-10`) | `5 to 50: 37` |

A natural 20 or natural 1 is called out when rolling a single d20, or with advantage or disadvantage. Limits on the number of dice, sides, parts and range sizes are set in `Config.Limits`, and each kind of roll can be turned off in `Config.Allow`.

## Configuration

All settings are in `configuration/config.lua`, each explained by a comment next to it.

| Setting | Default | What it does |
|---|---|---|
| `Config.Locale` | `'en'` | Language file from `locales/` |
| `Config.Commands.roll` | `'roll'` | The roll command |
| `Config.Commands.help` | `'rollhelp'` | The help command |
| `Config.Commands.aliases` | `{ 'dice' }` | Other names for the roll command |
| `Config.Permission` | `false` | `false` for everyone, or an ACE name to limit who can roll (see [Permissions](#permissions)) |
| `Config.Cooldown` | `2.0` | Seconds between a player's rolls. `0` to turn off |
| `Config.DefaultRoll` | `'1d20'` | What `/roll` on its own rolls |
| `Config.Limits.maxDice` | `20` | Most dice in one roll |
| `Config.Limits.maxSides` | `1000` | Most sides on a die |
| `Config.Limits.maxTerms` | `5` | Most parts in one roll, such as `2d6+1d4+3` |
| `Config.Limits.maxRange` | `1000000` | Largest number in a range or bonus |
| `Config.Allow.*` | all `true` | Turn coin, fate, range, keep/drop and advantage rolls on or off |
| `Config.Distance` | `20.0` | Metres within which players see a roll |
| `Config.Chat.enabled` | `true` | Show rolls in chat |
| `Config.Chat.colour` | `{ 167, 139, 250 }` | RGB colour of roll messages in chat |
| `Config.Floating.enabled` | `true` | Show rolls above the roller's head |
| `Config.Floating.seconds` | `6` | How long floating rolls stay |
| `Config.Floating.lineOfSight` | `true` | Only show floating rolls to players who can see the roller |
| `Config.Floating.font`, `scale`, `height` | `4`, `0.42`, `0.45` | Look and position of the floating text |
| `Config.Floating.colour`, `criticalColour`, `fumbleColour` | white, green, red | RGBA colours of floating text |
| `Config.Notifications` | `'auto'` | How the roller is told about mistakes: `'auto'` (ox_lib if running, otherwise chat), `'ox_lib'` or `'chat'` |
| `Config.LogToConsole` | `false` | Print every roll in the server console |

Server-only settings are in `configuration/server.lua`, which players never receive: the Discord webhook and the [character name](#character-names) function.

## Permissions

By default everyone can roll. To limit it, set an ACE name in `configuration/config.lua`:

```lua
Config.Permission = 'pigeon-dice.roll'
```

Then allow it in `server.cfg`, for example for everyone in a group:

```cfg
add_ace group.roleplayer pigeon-dice.roll allow
```

## Character names

Rolls show the player's FiveM name. To show their character's name, edit `ServerConfig.GetName` in `configuration/server.lua` to return it from your framework. For example, for Qbox:

```lua
function ServerConfig.GetName(source)
    local player = exports.qbx_core:GetPlayer(source)
    if player then
        local info = player.PlayerData.charinfo
        return info.firstname .. ' ' .. info.lastname
    end
    return GetPlayerName(source)
end
```

Names are always cleaned before they're shown: colour codes, HTML and Discord formatting are removed, and they're limited to 32 characters.

## Discord logging

To log every roll to a Discord channel, create a webhook in the channel's settings (**Integrations → Webhooks**) and add it to `server.cfg`, which keeps it out of the resource's files:

```cfg
set pigeon_dice_webhook "https://discord.com/api/webhooks/..."
```

Or set `ServerConfig.Webhook` in `configuration/server.lua`. Each log shows the player's name, server ID and the full roll. Discord allows about 30 webhook messages a minute, so use a dedicated channel on busy servers. Webhook messages can't mention anyone.

## Exports

For other server-side resources.

```lua
-- Roll without showing it to anyone.
-- Returns a result, or nil and a message explaining what was wrong with the roll.
local result, problem = exports['pigeon-dice']:Roll('2d6+3')
-- result = { kind = 'expression', label = '2d6+3', total = 12, detail = '[4, 5] + 3', natural = nil }
-- kind is 'expression', 'coin' (total is 'heads' or 'tails') or 'range'.
-- natural is 'critical', 'fumble' or nil.

-- Roll for a player and show it to everyone nearby, exactly like /roll.
-- Doesn't apply the cooldown or permission check.
local result, problem = exports['pigeon-dice']:RollFor(source, '1d20')
```

## Localisation

Set `Config.Locale` to a file in `locales/`. To add a language, copy `locales/en.lua` to a new file named with the language's two-letter code (such as `de.lua`), change `Locales.en` at the top to match (`Locales.de`), and translate the text in quotes. Keep anything in `{curly brackets}` exactly as it is. We'd love it if you shared it back; see [Contributing](#contributing).

## Update checker

When it starts, Pigeon Dice checks our public [version registry](https://github.com/WelshPigeon/pigeon-versions) once and prints one line in the server console saying whether it's up to date. If there's an update, it shows what's new and where to get it. The check is a single request to GitHub and sends nothing about your server or players.

Control it for every Pigeon Studios resource at once in `server.cfg`:

```cfg
set pigeon_update_check "on"      # default: one line per resource
set pigeon_update_check "quiet"   # only when there's an update or a problem
set pigeon_update_check "off"     # never check
```

## Performance

Nothing runs while nobody is rolling: the resource sits at 0.00 ms on the client and server. When a roll is floating above someone's head, the client draws it each frame and checks line of sight four times a second, for six seconds. The server handles a roll in well under a millisecond.

## Security

- The server rolls every die; the client only displays what it's sent. Players can't trigger rolls except through the command, which applies the cooldown and permission check.
- Nothing a player types is run as a command, and roll input is checked character by character, so only dice notation gets through.
- Rolls are sent only to players near the roller in the same routing bucket.
- Player names are cleaned before they reach chat, floating text or Discord.

Found a problem? Please don't open a public issue. Use the **Report a vulnerability** button in this repository's **Security** tab, or follow our [Security Policy](https://github.com/WelshPigeon/.github/blob/main/SECURITY.md).

## Troubleshooting

**Nothing happens when I type /roll.**
Check the server console for errors when the resource starts, and that the folder is called `pigeon-dice`. If `Config.Permission` is set, make sure your group has that ACE.

**Rolls don't appear in chat.**
Pigeon Dice uses the standard `chat:addMessage` event. Make sure your chat resource is running and starts before `pigeon-dice`. Some custom chat resources use different events; check their documentation.

**Floating text doesn't appear.**
It only shows to players within `Config.Distance` who can see the roller. Stand in the open and roll again, or set `Config.Floating.lineOfSight = false`.

**Players far away can see rolls.**
OneSync is probably off, so the server can't check positions. Their game should still ignore rolls from players it can't see nearby; turning on OneSync makes the server filter them instead.

**Errors show in chat instead of as notifications.**
Notifications use ox_lib if it's running. Start ox_lib before `pigeon-dice`, or set `Config.Notifications = 'ox_lib'`.

**The console says "isn't in the version registry" or "couldn't check for updates".**
Your server couldn't reach GitHub, or the check is blocked by a firewall. The resource works normally either way. Turn the check off with `set pigeon_update_check "off"`.

## FAQ

**Is it really free?**
Yes. Use it on as many servers as you like, including ones that take donations. You just can't reupload, resell or bundle it. See [Licence](#licence).

**Can I change it?**
Yes, for your own servers. If you've fixed or improved something, please send it back as a pull request.

**Does it work with my framework?**
It doesn't use one, so yes. To show character names, see [Character names](#character-names).

**Can players cheat their rolls?**
No. Every die is rolled on the server, and the result is sent to everyone at the same time.

## Support

Read [Troubleshooting](#troubleshooting) first, then ask in the support channels of our [Discord](https://discord.gg/2NFVWEUmDF). Please include your Pigeon Dice version, FXServer artifact and any errors from the console. See [Getting help](https://github.com/WelshPigeon/.github/blob/main/SUPPORT.md).

Found a bug? Open a [bug report](https://github.com/WelshPigeon/pigeon-dice/issues/new/choose).

## Contributing

Fixes, improvements and translations are welcome. Please read the [contributing guide](https://github.com/WelshPigeon/.github/blob/main/CONTRIBUTING.md) first, and open a feature request before working on anything big.

The dice engine and the resource have tests that run in plain Lua 5.4, with no server needed:

```bash
lua tests/dice.test.lua
lua tests/resource.test.lua
```

## Licence

Pigeon Dice is free to use under the **[Pigeon Studios Free Licence](LICENSE.md)**.

- ✅ Use it on any number of servers, including monetised ones
- ✅ Change it for your own servers
- ✅ Show it in videos and streams
- ❌ Don't reupload, share or mirror the files; link to this repository instead
- ❌ Don't sell it, bundle it in packs, or put it behind escrow
- ❌ Don't remove the credits

This summary isn't the licence; [LICENSE.md](LICENSE.md) is. Third-party notices are in [NOTICE.md](NOTICE.md).

## Credits

Made by [Pigeon Studios](https://pigeonstudios.co.uk). Thanks to everyone who has contributed fixes and translations; see the [changelog](CHANGELOG.md).

<sub>Not affiliated with or endorsed by Rockstar Games, Take-Two Interactive or Cfx.re.</sub>
