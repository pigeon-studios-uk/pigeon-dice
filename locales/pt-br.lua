--[[
    Pigeon Dice: Brazilian Portuguese (Português do Brasil).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'pt-br'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales['pt-br'] = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} rola {label}: {total}  {detail}',
    chat_range = '* {name} escolhe um número de {low} a {high}: {total}',
    chat_coin = '* {name} joga uma moeda: {result}',
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
    error_invalid = 'Não entendi essa rolagem. Digite /{help} para ver exemplos.',
    error_disabled = 'Esse tipo de rolagem está desativado neste servidor.',
    error_range_small = 'Um intervalo precisa de dois números diferentes, como 1-100.',
    error_range_large = 'Os números de um intervalo podem ir até {max}.',
    error_sides = 'Os dados podem ter de 2 a {max} lados.',
    error_too_many_dice = 'Você pode rolar até {max} dados de uma vez.',
    error_too_many_terms = 'Uma rolagem pode ter até {max} partes, como 2d6+1d4+3.',
    error_keep = 'Mantenha ou descarte uma quantidade de dados entre 1 e {count}.',
    error_cooldown = 'Espere um momento antes de rolar de novo.',
    error_permission = 'Você não tem permissão para rolar dados.',

    -- Chat command suggestions.
    suggest_roll = 'Role dados para todos por perto verem',
    suggest_roll_param = 'rolagem',
    suggest_roll_param_help = 'Como d20, 2d6+3, 4d6kh3, adv, dis, fate, coin ou 1-100',
    suggest_help = 'Mostra tudo que /{roll} sabe fazer',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: o que /{roll} entende',
    help_default = '/{roll}  rola {default}',
    help_dice = '/{roll} d20  / 3d6  rola dados',
    help_math = '/{roll} 2d6+3  soma ou subtrai, até {terms} partes (como 2d6+1d4-1)',
    help_percentile = '/{roll} d%  rola um dado percentual (1-100)',
    help_keep = '/{roll} 4d6kh3  mantém os 3 maiores (kl mantém os menores; dh, dl descartam o maior, o menor)',
    help_advantage = '/{roll} adv  / dis  rola 2d20 com vantagem ou desvantagem',
    help_fate = '/{roll} fate  / 4dF  rola dados Fate (cada um -, 0 ou +)',
    help_coin = '/{roll} coin  joga uma moeda',
    help_range = '/{roll} 100  / 5-50  escolhe um número em um intervalo',
    help_footer = 'Dados descartados aparecem entre (parênteses). Jogadores a até {distance} metros veem sua rolagem.',
}
