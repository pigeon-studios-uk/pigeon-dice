# Changelog

All notable changes to Pigeon Dice are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html):

- **Major** versions can need changes to your configuration or other resources. Read the **Upgrade notes**.
- **Minor** versions add features without breaking existing setups.
- **Patch** versions fix bugs only.

## [Unreleased]

## [2.0.0] - 2026-10-18

A complete rewrite of Pigeon Dice.

### Upgrade notes

- Replace the `pigeon-dice` folder completely and set up `configuration/config.lua` again; the settings have changed.
- ox_lib is no longer required. It's still used for notifications if it's running.
- A `/do` command is no longer needed.
- Event names have changed. If another resource listened for `dr_rolls:*` events, use the new [exports](README.md#exports) instead.

### Added

- Rolls with several parts added or subtracted, such as `2d6+1d4+3`.
- Keep lowest (`kl`) and drop highest (`dh`), alongside keep highest and drop lowest.
- Percentile dice (`d%`) and any number of Fate dice (`6dF`).
- Floating text above the roller's head, shown only to players nearby who can see them.
- Natural 20s and natural 1s called out in chat and coloured in floating text.
- Rolls sent only to players nearby in the same routing bucket, worked out by the server.
- Optional ACE permission for rolling.
- Optional character names from any framework, through `ServerConfig.GetName`.
- Optional Discord webhook and console logging.
- `Roll` and `RollFor` exports for other resources.
- Chat suggestions for `/roll`, its aliases and `/rollhelp`.
- `/rollhelp` lists only the kinds of roll turned on.
- `pigeon-dice_test` console command for checking rolls without joining.
- Every player-facing message in `locales/`.
- Update checker from the new Pigeon Studios version registry.
- Tests for the dice engine and the resource, runnable in plain Lua 5.4.

### Changed

- Every roll is made and formatted on the server; the client only displays it.
- The cooldown is measured in milliseconds and cleared when a player leaves.
- Dropped dice are shown in brackets, in the order they were rolled.
- Errors use ox_lib notifications when available, otherwise chat.

### Fixed

- A roll was posted once for every nearby player, under each of their names, because every nearby game ran `/do` with the result. It's now posted once, as the roller.
- Rolls didn't show at all on servers without a `/do` command.

### Removed

- The ox_lib help menu; `/rollhelp` now lists everything in chat.
- The dependency on ox_lib.

[Unreleased]: https://github.com/WelshPigeon/pigeon-dice/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/WelshPigeon/pigeon-dice/releases/tag/v2.0.0
