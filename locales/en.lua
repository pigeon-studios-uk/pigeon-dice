--[[
    Pigeon Dice: English.

    To translate, copy this file to a new one named with the language's two-letter code (such as de.lua),
    change `Locales.en` to match (Locales.de), translate the text in quotes, and set Config.Locale.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.en = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} rolls {label}: {total}  {detail}',
    chat_range = '* {name} picks a number from {low} to {high}: {total}',
    chat_coin = '* {name} flips a coin: {result}',
    chat_critical = ' (natural 20!)',
    chat_fumble = ' (natural 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Coin: {result}',

    heads = 'Heads',
    tails = 'Tails',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'That isn\'t a roll I understand. Type /{help} to see examples.',
    error_disabled = 'That kind of roll is turned off on this server.',
    error_range_small = 'A range needs two different numbers, such as 1-100.',
    error_range_large = 'Numbers in a range can be up to {max}.',
    error_sides = 'Dice can have 2 to {max} sides.',
    error_too_many_dice = 'You can roll up to {max} dice at once.',
    error_too_many_terms = 'A roll can have up to {max} parts, such as 2d6+1d4+3.',
    error_keep = 'Keep or drop a number of dice between 1 and {count}.',
    error_cooldown = 'Wait a moment before rolling again.',
    error_permission = 'You don\'t have permission to roll dice.',

    -- Chat command suggestions.
    suggest_roll = 'Roll dice for everyone nearby to see',
    suggest_roll_param = 'roll',
    suggest_roll_param_help = 'Such as d20, 2d6+3, 4d6kh3, adv, dis, fate, coin or 1-100',
    suggest_help = 'Show everything /{roll} can do',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: what /{roll} understands',
    help_default = '/{roll}  rolls {default}',
    help_dice = '/{roll} d20  or  3d6  rolls dice',
    help_math = '/{roll} 2d6+3  adds or subtracts, up to {terms} parts (such as 2d6+1d4-1)',
    help_percentile = '/{roll} d%  rolls a percentile die (1-100)',
    help_keep = '/{roll} 4d6kh3  keeps the highest 3 (kl keeps lowest; dh, dl drop highest, lowest)',
    help_advantage = '/{roll} adv  or  dis  rolls 2d20 with advantage or disadvantage',
    help_fate = '/{roll} fate  or  4dF  rolls Fate dice (each -, 0 or +)',
    help_coin = '/{roll} coin  flips a coin',
    help_range = '/{roll} 100  or  5-50  picks a number in a range',
    help_footer = 'Dropped dice show in (brackets). Players within {distance} metres see your roll.',
}
