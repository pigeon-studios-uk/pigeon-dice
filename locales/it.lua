--[[
    Pigeon Dice: Italian (Italiano).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'it'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.it = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} tira {label}: {total}  {detail}',
    chat_range = '* {name} sceglie un numero da {low} a {high}: {total}',
    chat_coin = '* {name} lancia una moneta: {result}',
    chat_critical = ' (20 naturale!)',
    chat_fumble = ' (1 naturale)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Moneta: {result}',

    heads = 'Testa',
    tails = 'Croce',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Non capisco quel tiro. Scrivi /{help} per vedere degli esempi.',
    error_disabled = 'Questo tipo di tiro è disattivato su questo server.',
    error_range_small = 'Un intervallo richiede due numeri diversi, come 1-100.',
    error_range_large = 'I numeri di un intervallo possono arrivare a {max}.',
    error_sides = 'I dadi possono avere da 2 a {max} facce.',
    error_too_many_dice = 'Puoi tirare fino a {max} dadi alla volta.',
    error_too_many_terms = 'Un tiro può avere fino a {max} parti, come 2d6+1d4+3.',
    error_keep = 'Tieni o scarta un numero di dadi tra 1 e {count}.',
    error_cooldown = 'Aspetta un attimo prima di tirare di nuovo.',
    error_permission = 'Non hai il permesso di tirare i dadi.',

    -- Chat command suggestions.
    suggest_roll = 'Tira i dadi davanti a chi ti sta vicino',
    suggest_roll_param = 'tiro',
    suggest_roll_param_help = 'Come d20, 2d6+3, 4d6kh3, adv, dis, fate, coin o 1-100',
    suggest_help = 'Mostra tutto quello che sa fare /{roll}',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: cosa capisce /{roll}',
    help_default = '/{roll}  tira {default}',
    help_dice = '/{roll} d20  / 3d6  tira i dadi',
    help_math = '/{roll} 2d6+3  somma o sottrae, fino a {terms} parti (come 2d6+1d4-1)',
    help_percentile = '/{roll} d%  tira un dado percentuale (1-100)',
    help_keep = '/{roll} 4d6kh3  tiene i 3 più alti (kl tiene i più bassi; dh, dl scartano il più alto, il più basso)',
    help_advantage = '/{roll} adv  / dis  tira 2d20 con vantaggio o svantaggio',
    help_fate = '/{roll} fate  / 4dF  tira dadi Fate (ognuno -, 0 o +)',
    help_coin = '/{roll} coin  lancia una moneta',
    help_range = '/{roll} 100  / 5-50  sceglie un numero in un intervallo',
    help_footer = 'I dadi scartati sono tra (parentesi). I giocatori entro {distance} metri vedono il tuo tiro.',
}
