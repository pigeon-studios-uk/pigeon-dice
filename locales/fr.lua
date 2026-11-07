--[[
    Pigeon Dice: French (Français).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'fr'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.fr = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} lance {label}: {total}  {detail}',
    chat_range = '* {name} choisit un nombre de {low} à {high}: {total}',
    chat_coin = '* {name} lance une pièce: {result}',
    chat_critical = ' (20 naturel !)',
    chat_fumble = ' (1 naturel)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Pièce: {result}',

    heads = 'Face',
    tails = 'Pile',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Je ne comprends pas ce lancer. Tapez /{help} pour voir des exemples.',
    error_disabled = 'Ce type de lancer est désactivé sur ce serveur.',
    error_range_small = 'Un intervalle a besoin de deux nombres différents, comme 1-100.',
    error_range_large = 'Les nombres d\'un intervalle peuvent aller jusqu\'à {max}.',
    error_sides = 'Les dés peuvent avoir de 2 à {max} faces.',
    error_too_many_dice = 'Vous pouvez lancer jusqu\'à {max} dés à la fois.',
    error_too_many_terms = 'Un lancer peut avoir jusqu\'à {max} parties, comme 2d6+1d4+3.',
    error_keep = 'Gardez ou retirez un nombre de dés entre 1 et {count}.',
    error_cooldown = 'Attendez un instant avant de relancer.',
    error_permission = 'Vous n\'avez pas la permission de lancer des dés.',

    -- Chat command suggestions.
    suggest_roll = 'Lancez des dés à la vue de tous ceux qui sont proches',
    suggest_roll_param = 'lancer',
    suggest_roll_param_help = 'Comme d20, 2d6+3, 4d6kh3, adv, dis, fate, coin ou 1-100',
    suggest_help = 'Affiche tout ce que /{roll} sait faire',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice : ce que comprend /{roll}',
    help_default = '/{roll}  lance {default}',
    help_dice = '/{roll} d20  / 3d6  lance des dés',
    help_math = '/{roll} 2d6+3  additionne ou soustrait, jusqu\'à {terms} parties (comme 2d6+1d4-1)',
    help_percentile = '/{roll} d%  lance un dé de pourcentage (1-100)',
    help_keep = '/{roll} 4d6kh3  garde les 3 plus hauts (kl garde les plus bas ; dh, dl retirent le plus haut, le plus bas)',
    help_advantage = '/{roll} adv  / dis  lance 2d20 avec avantage ou désavantage',
    help_fate = '/{roll} fate  / 4dF  lance des dés Fate (chacun -, 0 ou +)',
    help_coin = '/{roll} coin  lance une pièce',
    help_range = '/{roll} 100  / 5-50  choisit un nombre dans un intervalle',
    help_footer = 'Les dés retirés sont entre (parenthèses). Les joueurs à moins de {distance} mètres voient votre lancer.',
}
