--[[
    Pigeon Dice: Polish (Polski).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'pl'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.pl = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} rzuca {label}: {total}  {detail}',
    chat_range = '* {name} losuje liczbę od {low} do {high}: {total}',
    chat_coin = '* {name} rzuca monetą: {result}',
    chat_critical = ' (naturalna 20!)',
    chat_fumble = ' (naturalna 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Moneta: {result}',

    heads = 'Orzeł',
    tails = 'Reszka',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Nie rozumiem tego rzutu. Wpisz /{help}, aby zobaczyć przykłady.',
    error_disabled = 'Ten rodzaj rzutu jest wyłączony na tym serwerze.',
    error_range_small = 'Zakres potrzebuje dwóch różnych liczb, np. 1-100.',
    error_range_large = 'Liczby w zakresie mogą wynosić najwyżej {max}.',
    error_sides = 'Kości mogą mieć od 2 do {max} ścianek.',
    error_too_many_dice = 'Możesz rzucić najwyżej {max} kośćmi naraz.',
    error_too_many_terms = 'Rzut może mieć najwyżej {max} części, np. 2d6+1d4+3.',
    error_keep = 'Zachowaj lub odrzuć od 1 do {count} kości.',
    error_cooldown = 'Poczekaj chwilę przed kolejnym rzutem.',
    error_permission = 'Nie masz uprawnień do rzucania kośćmi.',

    -- Chat command suggestions.
    suggest_roll = 'Rzuć kośćmi, żeby wszyscy w pobliżu widzieli',
    suggest_roll_param = 'rzut',
    suggest_roll_param_help = 'Np. d20, 2d6+3, 4d6kh3, adv, dis, fate, coin lub 1-100',
    suggest_help = 'Pokaż wszystko, co potrafi /{roll}',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: co rozumie /{roll}',
    help_default = '/{roll}  rzuca {default}',
    help_dice = '/{roll} d20  / 3d6  rzuca kośćmi',
    help_math = '/{roll} 2d6+3  dodaje lub odejmuje, najwyżej {terms} części (np. 2d6+1d4-1)',
    help_percentile = '/{roll} d%  rzuca kością procentową (1-100)',
    help_keep = '/{roll} 4d6kh3  zachowuje 3 najwyższe (kl zachowuje najniższe; dh, dl odrzucają najwyższą, najniższą)',
    help_advantage = '/{roll} adv  / dis  rzuca 2d20 z ułatwieniem lub utrudnieniem',
    help_fate = '/{roll} fate  / 4dF  rzuca kośćmi Fate (każda -, 0 lub +)',
    help_coin = '/{roll} coin  rzuca monetą',
    help_range = '/{roll} 100  / 5-50  losuje liczbę z zakresu',
    help_footer = 'Odrzucone kości są w (nawiasach). Gracze w promieniu {distance} metrów widzą twój rzut.',
}
