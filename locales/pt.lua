--[[
    Pigeon Dice: Portuguese (Português).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'pt'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.pt = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} lança {label}: {total}  {detail}',
    chat_range = '* {name} escolhe um número de {low} a {high}: {total}',
    chat_coin = '* {name} atira uma moeda ao ar: {result}',
    chat_critical = ' (20 natural!)',
    chat_fumble = ' (1 natural)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Moeda: {result}',

    heads = 'Cara',
    tails = 'Coroa',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Não percebo esse lançamento. Escreve /{help} para veres exemplos.',
    error_disabled = 'Esse tipo de lançamento está desligado neste servidor.',
    error_range_small = 'Um intervalo precisa de dois números diferentes, como 1-100.',
    error_range_large = 'Os números de um intervalo podem ir até {max}.',
    error_sides = 'Os dados podem ter de 2 a {max} faces.',
    error_too_many_dice = 'Podes lançar até {max} dados de uma vez.',
    error_too_many_terms = 'Um lançamento pode ter até {max} partes, como 2d6+1d4+3.',
    error_keep = 'Mantém ou descarta um número de dados entre 1 e {count}.',
    error_cooldown = 'Espera um momento antes de lançar outra vez.',
    error_permission = 'Não tens permissão para lançar dados.',

    -- Chat command suggestions.
    suggest_roll = 'Lança dados para todos à tua volta verem',
    suggest_roll_param = 'lançamento',
    suggest_roll_param_help = 'Como d20, 2d6+3, 4d6kh3, adv, dis, fate, coin ou 1-100',
    suggest_help = 'Mostra tudo o que /{roll} sabe fazer',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: o que /{roll} percebe',
    help_default = '/{roll}  lança {default}',
    help_dice = '/{roll} d20  / 3d6  lança dados',
    help_math = '/{roll} 2d6+3  soma ou subtrai, até {terms} partes (como 2d6+1d4-1)',
    help_percentile = '/{roll} d%  lança um dado de percentagem (1-100)',
    help_keep = '/{roll} 4d6kh3  mantém os 3 mais altos (kl mantém os mais baixos; dh, dl descartam o mais alto, o mais baixo)',
    help_advantage = '/{roll} adv  / dis  lança 2d20 com vantagem ou desvantagem',
    help_fate = '/{roll} fate  / 4dF  lança dados Fate (cada um -, 0 ou +)',
    help_coin = '/{roll} coin  atira uma moeda ao ar',
    help_range = '/{roll} 100  / 5-50  escolhe um número num intervalo',
    help_footer = 'Os dados descartados aparecem entre (parênteses). Os jogadores a menos de {distance} metros veem o teu lançamento.',
}
