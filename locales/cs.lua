--[[
    Pigeon Dice: Czech (Čeština).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'cs'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.cs = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} hází {label}: {total}  {detail}',
    chat_range = '* {name} vybírá číslo od {low} do {high}: {total}',
    chat_coin = '* {name} hází mincí: {result}',
    chat_critical = ' (přirozená 20!)',
    chat_fumble = ' (přirozená 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Mince: {result}',

    heads = 'Panna',
    tails = 'Orel',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Tomuhle hodu nerozumím. Napiš /{help} a uvidíš příklady.',
    error_disabled = 'Tento druh hodu je na serveru vypnutý.',
    error_range_small = 'Rozsah potřebuje dvě různá čísla, třeba 1-100.',
    error_range_large = 'Čísla v rozsahu můžou být nejvýš {max}.',
    error_sides = 'Kostky můžou mít 2 až {max} stěn.',
    error_too_many_dice = 'Najednou můžeš hodit nejvýš {max} kostek.',
    error_too_many_terms = 'Hod může mít nejvýš {max} částí, třeba 2d6+1d4+3.',
    error_keep = 'Ponech nebo zahoď počet kostek mezi 1 a {count}.',
    error_cooldown = 'Než hodíš znovu, chvilku počkej.',
    error_permission = 'Nemáš oprávnění házet kostkami.',

    -- Chat command suggestions.
    suggest_roll = 'Hoď kostkami, aby to viděli všichni poblíž',
    suggest_roll_param = 'hod',
    suggest_roll_param_help = 'Třeba d20, 2d6+3, 4d6kh3, adv, dis, fate, coin nebo 1-100',
    suggest_help = 'Ukáže vše, co /{roll} umí',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: čemu /{roll} rozumí',
    help_default = '/{roll}  hodí {default}',
    help_dice = '/{roll} d20  / 3d6  hodí kostkami',
    help_math = '/{roll} 2d6+3  sčítá nebo odčítá, nejvýš {terms} částí (třeba 2d6+1d4-1)',
    help_percentile = '/{roll} d%  hodí procentní kostkou (1-100)',
    help_keep = '/{roll} 4d6kh3  ponechá 3 nejvyšší (kl ponechá nejnižší; dh, dl zahodí nejvyšší, nejnižší)',
    help_advantage = '/{roll} adv  / dis  hodí 2d20 s výhodou nebo nevýhodou',
    help_fate = '/{roll} fate  / 4dF  hodí Fate kostkami (každá -, 0 nebo +)',
    help_coin = '/{roll} coin  hodí mincí',
    help_range = '/{roll} 100  / 5-50  vybere číslo z rozsahu',
    help_footer = 'Zahozené kostky jsou v (závorkách). Tvůj hod uvidí hráči do {distance} metrů.',
}
