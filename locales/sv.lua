--[[
    Pigeon Dice: Swedish (Svenska).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'sv'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.sv = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} slår {label}: {total}  {detail}',
    chat_range = '* {name} väljer ett tal från {low} till {high}: {total}',
    chat_coin = '* {name} singlar slant: {result}',
    chat_critical = ' (naturlig 20!)',
    chat_fumble = ' (naturlig 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Mynt: {result}',

    heads = 'Krona',
    tails = 'Klave',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Det slaget förstår jag inte. Skriv /{help} för att se exempel.',
    error_disabled = 'Den sortens slag är avstängd på den här servern.',
    error_range_small = 'Ett intervall behöver två olika tal, till exempel 1-100.',
    error_range_large = 'Tal i ett intervall kan vara upp till {max}.',
    error_sides = 'Tärningar kan ha 2 till {max} sidor.',
    error_too_many_dice = 'Du kan slå upp till {max} tärningar på en gång.',
    error_too_many_terms = 'Ett slag kan ha upp till {max} delar, till exempel 2d6+1d4+3.',
    error_keep = 'Behåll eller släng ett antal tärningar mellan 1 och {count}.',
    error_cooldown = 'Vänta en stund innan du slår igen.',
    error_permission = 'Du har inte behörighet att slå tärning.',

    -- Chat command suggestions.
    suggest_roll = 'Slå tärning så att alla i närheten ser',
    suggest_roll_param = 'slag',
    suggest_roll_param_help = 'Till exempel d20, 2d6+3, 4d6kh3, adv, dis, fate, coin eller 1-100',
    suggest_help = 'Visa allt /{roll} kan göra',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: vad /{roll} förstår',
    help_default = '/{roll}  slår {default}',
    help_dice = '/{roll} d20  / 3d6  slår tärningar',
    help_math = '/{roll} 2d6+3  lägger till eller drar ifrån, upp till {terms} delar (till exempel 2d6+1d4-1)',
    help_percentile = '/{roll} d%  slår en procenttärning (1-100)',
    help_keep = '/{roll} 4d6kh3  behåller de 3 högsta (kl behåller de lägsta; dh, dl slänger högsta, lägsta)',
    help_advantage = '/{roll} adv  / dis  slår 2d20 med fördel eller nackdel',
    help_fate = '/{roll} fate  / 4dF  slår Fate-tärningar (var och en -, 0 eller +)',
    help_coin = '/{roll} coin  singlar slant',
    help_range = '/{roll} 100  / 5-50  väljer ett tal i ett intervall',
    help_footer = 'Slängda tärningar visas inom (parentes). Spelare inom {distance} meter ser ditt slag.',
}
