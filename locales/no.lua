--[[
    Pigeon Dice: Norwegian (Norsk).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'no'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.no = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} kaster {label}: {total}  {detail}',
    chat_range = '* {name} velger et tall fra {low} til {high}: {total}',
    chat_coin = '* {name} kaster mynt: {result}',
    chat_critical = ' (naturlig 20!)',
    chat_fumble = ' (naturlig 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Mynt: {result}',

    heads = 'Kron',
    tails = 'Mynt',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Det kastet forstår jeg ikke. Skriv /{help} for å se eksempler.',
    error_disabled = 'Den typen kast er slått av på denne serveren.',
    error_range_small = 'Et intervall trenger to forskjellige tall, for eksempel 1-100.',
    error_range_large = 'Tall i et intervall kan være opptil {max}.',
    error_sides = 'Terninger kan ha 2 til {max} sider.',
    error_too_many_dice = 'Du kan kaste opptil {max} terninger om gangen.',
    error_too_many_terms = 'Et kast kan ha opptil {max} deler, for eksempel 2d6+1d4+3.',
    error_keep = 'Behold eller fjern et antall terninger mellom 1 og {count}.',
    error_cooldown = 'Vent litt før du kaster igjen.',
    error_permission = 'Du har ikke tillatelse til å kaste terninger.',

    -- Chat command suggestions.
    suggest_roll = 'Kast terninger så alle i nærheten ser det',
    suggest_roll_param = 'kast',
    suggest_roll_param_help = 'For eksempel d20, 2d6+3, 4d6kh3, adv, dis, fate, coin eller 1-100',
    suggest_help = 'Vis alt /{roll} kan gjøre',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: hva /{roll} forstår',
    help_default = '/{roll}  kaster {default}',
    help_dice = '/{roll} d20  / 3d6  kaster terninger',
    help_math = '/{roll} 2d6+3  legger til eller trekker fra, opptil {terms} deler (for eksempel 2d6+1d4-1)',
    help_percentile = '/{roll} d%  kaster en prosentterning (1-100)',
    help_keep = '/{roll} 4d6kh3  beholder de 3 høyeste (kl beholder laveste; dh, dl fjerner høyeste, laveste)',
    help_advantage = '/{roll} adv  / dis  kaster 2d20 med fordel eller ulempe',
    help_fate = '/{roll} fate  / 4dF  kaster Fate-terninger (hver -, 0 eller +)',
    help_coin = '/{roll} coin  kaster mynt',
    help_range = '/{roll} 100  / 5-50  velger et tall i et intervall',
    help_footer = 'Fjernede terninger vises i (parentes). Spillere innenfor {distance} meter ser kastet ditt.',
}
