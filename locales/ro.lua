--[[
    Pigeon Dice: Romanian (Română).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'ro'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.ro = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} aruncă {label}: {total}  {detail}',
    chat_range = '* {name} alege un număr de la {low} la {high}: {total}',
    chat_coin = '* {name} dă cu banul: {result}',
    chat_critical = ' (20 natural!)',
    chat_fumble = ' (1 natural)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Monedă: {result}',

    heads = 'Cap',
    tails = 'Pajură',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Nu înțeleg aruncarea asta. Scrie /{help} ca să vezi exemple.',
    error_disabled = 'Acest tip de aruncare este dezactivat pe server.',
    error_range_small = 'Un interval are nevoie de două numere diferite, de exemplu 1-100.',
    error_range_large = 'Numerele dintr-un interval pot fi de cel mult {max}.',
    error_sides = 'Zarurile pot avea între 2 și {max} fețe.',
    error_too_many_dice = 'Poți arunca cel mult {max} zaruri odată.',
    error_too_many_terms = 'O aruncare poate avea cel mult {max} părți, de exemplu 2d6+1d4+3.',
    error_keep = 'Păstrează sau elimină între 1 și {count} zaruri.',
    error_cooldown = 'Așteaptă puțin înainte să arunci din nou.',
    error_permission = 'Nu ai permisiunea să arunci zarurile.',

    -- Chat command suggestions.
    suggest_roll = 'Aruncă zarurile ca să vadă toți cei din apropiere',
    suggest_roll_param = 'aruncare',
    suggest_roll_param_help = 'De exemplu d20, 2d6+3, 4d6kh3, adv, dis, fate, coin sau 1-100',
    suggest_help = 'Arată tot ce poate face /{roll}',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: ce înțelege /{roll}',
    help_default = '/{roll}  aruncă {default}',
    help_dice = '/{roll} d20  / 3d6  aruncă zaruri',
    help_math = '/{roll} 2d6+3  adună sau scade, cel mult {terms} părți (de exemplu 2d6+1d4-1)',
    help_percentile = '/{roll} d%  aruncă un zar procentual (1-100)',
    help_keep = '/{roll} 4d6kh3  păstrează cele mai mari 3 (kl le păstrează pe cele mai mici; dh, dl elimină cel mai mare, cel mai mic)',
    help_advantage = '/{roll} adv  / dis  aruncă 2d20 cu avantaj sau dezavantaj',
    help_fate = '/{roll} fate  / 4dF  aruncă zaruri Fate (fiecare -, 0 sau +)',
    help_coin = '/{roll} coin  dă cu banul',
    help_range = '/{roll} 100  / 5-50  alege un număr dintr-un interval',
    help_footer = 'Zarurile eliminate apar în (paranteze). Jucătorii aflați la cel mult {distance} metri îți văd aruncarea.',
}
