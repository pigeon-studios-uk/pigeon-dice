--[[
    Pigeon Dice: Spanish (Español).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'es'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.es = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} tira {label}: {total}  {detail}',
    chat_range = '* {name} elige un número del {low} al {high}: {total}',
    chat_coin = '* {name} lanza una moneda: {result}',
    chat_critical = ' (¡20 natural!)',
    chat_fumble = ' (1 natural)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Moneda: {result}',

    heads = 'Cara',
    tails = 'Cruz',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'No entiendo esa tirada. Escribe /{help} para ver ejemplos.',
    error_disabled = 'Ese tipo de tirada está desactivado en este servidor.',
    error_range_small = 'Un rango necesita dos números distintos, como 1-100.',
    error_range_large = 'Los números de un rango pueden llegar hasta {max}.',
    error_sides = 'Los dados pueden tener de 2 a {max} caras.',
    error_too_many_dice = 'Puedes tirar hasta {max} dados a la vez.',
    error_too_many_terms = 'Una tirada puede tener hasta {max} partes, como 2d6+1d4+3.',
    error_keep = 'Quédate con o descarta un número de dados entre 1 y {count}.',
    error_cooldown = 'Espera un momento antes de volver a tirar.',
    error_permission = 'No tienes permiso para tirar dados.',

    -- Chat command suggestions.
    suggest_roll = 'Tira dados para que los vea todo el mundo cerca',
    suggest_roll_param = 'tirada',
    suggest_roll_param_help = 'Como d20, 2d6+3, 4d6kh3, adv, dis, fate, coin o 1-100',
    suggest_help = 'Muestra todo lo que puede hacer /{roll}',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: lo que entiende /{roll}',
    help_default = '/{roll}  tira {default}',
    help_dice = '/{roll} d20  / 3d6  tira dados',
    help_math = '/{roll} 2d6+3  suma o resta, hasta {terms} partes (como 2d6+1d4-1)',
    help_percentile = '/{roll} d%  tira un dado de porcentaje (1-100)',
    help_keep = '/{roll} 4d6kh3  se queda con los 3 más altos (kl los más bajos; dh, dl descartan el más alto, el más bajo)',
    help_advantage = '/{roll} adv  / dis  tira 2d20 con ventaja o desventaja',
    help_fate = '/{roll} fate  / 4dF  tira dados Fate (cada uno -, 0 o +)',
    help_coin = '/{roll} coin  lanza una moneda',
    help_range = '/{roll} 100  / 5-50  elige un número dentro de un rango',
    help_footer = 'Los dados descartados salen entre (paréntesis). Los jugadores a menos de {distance} metros ven tu tirada.',
}
