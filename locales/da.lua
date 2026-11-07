--[[
    Pigeon Dice: Danish (Dansk).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'da'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.da = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} slår {label}: {total}  {detail}',
    chat_range = '* {name} vælger et tal fra {low} til {high}: {total}',
    chat_coin = '* {name} slår plat og krone: {result}',
    chat_critical = ' (naturlig 20!)',
    chat_fumble = ' (naturlig 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Mønt: {result}',

    heads = 'Krone',
    tails = 'Plat',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Det slag forstår jeg ikke. Skriv /{help} for at se eksempler.',
    error_disabled = 'Den slags slag er slået fra på denne server.',
    error_range_small = 'Et interval skal have to forskellige tal, fx 1-100.',
    error_range_large = 'Tal i et interval kan højst være {max}.',
    error_sides = 'Terninger kan have 2 til {max} sider.',
    error_too_many_dice = 'Du kan højst slå {max} terninger ad gangen.',
    error_too_many_terms = 'Et slag kan højst have {max} dele, fx 2d6+1d4+3.',
    error_keep = 'Behold eller fjern et antal terninger mellem 1 og {count}.',
    error_cooldown = 'Vent et øjeblik, før du slår igen.',
    error_permission = 'Du har ikke tilladelse til at slå med terninger.',

    -- Chat command suggestions.
    suggest_roll = 'Slå med terninger, så alle i nærheden kan se det',
    suggest_roll_param = 'slag',
    suggest_roll_param_help = 'Fx d20, 2d6+3, 4d6kh3, adv, dis, fate, coin eller 1-100',
    suggest_help = 'Vis alt, hvad /{roll} kan',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: hvad /{roll} forstår',
    help_default = '/{roll}  slår {default}',
    help_dice = '/{roll} d20  / 3d6  slår terninger',
    help_math = '/{roll} 2d6+3  lægger til eller trækker fra, op til {terms} dele (fx 2d6+1d4-1)',
    help_percentile = '/{roll} d%  slår en procentterning (1-100)',
    help_keep = '/{roll} 4d6kh3  beholder de 3 højeste (kl beholder laveste; dh, dl fjerner højeste, laveste)',
    help_advantage = '/{roll} adv  / dis  slår 2d20 med fordel eller ulempe',
    help_fate = '/{roll} fate  / 4dF  slår Fate-terninger (hver -, 0 eller +)',
    help_coin = '/{roll} coin  slår plat og krone',
    help_range = '/{roll} 100  / 5-50  vælger et tal i et interval',
    help_footer = 'Fjernede terninger vises i (parentes). Spillere inden for {distance} meter ser dit slag.',
}
