--[[
    Pigeon Dice: Dutch (Nederlands).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'nl'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.nl = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} gooit {label}: {total}  {detail}',
    chat_range = '* {name} kiest een getal van {low} tot {high}: {total}',
    chat_coin = '* {name} gooit een munt op: {result}',
    chat_critical = ' (natuurlijke 20!)',
    chat_fumble = ' (natuurlijke 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Munt: {result}',

    heads = 'Kop',
    tails = 'Munt',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Die worp begrijp ik niet. Typ /{help} voor voorbeelden.',
    error_disabled = 'Dat soort worp staat uit op deze server.',
    error_range_small = 'Een bereik heeft twee verschillende getallen nodig, zoals 1-100.',
    error_range_large = 'Getallen in een bereik kunnen tot {max} gaan.',
    error_sides = 'Dobbelstenen kunnen 2 tot {max} zijden hebben.',
    error_too_many_dice = 'Je kunt tot {max} dobbelstenen tegelijk gooien.',
    error_too_many_terms = 'Een worp kan tot {max} delen hebben, zoals 2d6+1d4+3.',
    error_keep = 'Houd of laat een aantal dobbelstenen vallen tussen 1 en {count}.',
    error_cooldown = 'Wacht even voordat je opnieuw gooit.',
    error_permission = 'Je hebt geen toestemming om te dobbelen.',

    -- Chat command suggestions.
    suggest_roll = 'Gooi dobbelstenen zodat iedereen in de buurt het ziet',
    suggest_roll_param = 'worp',
    suggest_roll_param_help = 'Zoals d20, 2d6+3, 4d6kh3, adv, dis, fate, coin of 1-100',
    suggest_help = 'Laat alles zien wat /{roll} kan',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: wat /{roll} begrijpt',
    help_default = '/{roll}  gooit {default}',
    help_dice = '/{roll} d20  / 3d6  gooit dobbelstenen',
    help_math = '/{roll} 2d6+3  telt op of trekt af, tot {terms} delen (zoals 2d6+1d4-1)',
    help_percentile = '/{roll} d%  gooit een procentdobbelsteen (1-100)',
    help_keep = '/{roll} 4d6kh3  houdt de hoogste 3 (kl houdt de laagste; dh, dl laten de hoogste, laagste vallen)',
    help_advantage = '/{roll} adv  / dis  gooit 2d20 met voordeel of nadeel',
    help_fate = '/{roll} fate  / 4dF  gooit Fate-dobbelstenen (elk -, 0 of +)',
    help_coin = '/{roll} coin  gooit een munt op',
    help_range = '/{roll} 100  / 5-50  kiest een getal binnen een bereik',
    help_footer = 'Weggelaten dobbelstenen staan tussen (haakjes). Spelers binnen {distance} meter zien je worp.',
}
