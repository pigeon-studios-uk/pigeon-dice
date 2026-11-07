--[[
    Pigeon Dice: Hungarian (Magyar).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'hu'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.hu = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} dobása ({label}): {total}  {detail}',
    chat_range = '* {name} számot választ {low} és {high} között: {total}',
    chat_coin = '* {name} feldob egy érmét: {result}',
    chat_critical = ' (természetes 20!)',
    chat_fumble = ' (természetes 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Érme: {result}',

    heads = 'Fej',
    tails = 'Írás',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Ezt a dobást nem értem. Írd be: /{help} a példákért.',
    error_disabled = 'Ez a fajta dobás ki van kapcsolva ezen a szerveren.',
    error_range_small = 'A tartományhoz két különböző szám kell, például 1-100.',
    error_range_large = 'A tartomány számai legfeljebb {max} lehetnek.',
    error_sides = 'A kockáknak 2-{max} oldaluk lehet.',
    error_too_many_dice = 'Egyszerre legfeljebb {max} kockával dobhatsz.',
    error_too_many_terms = 'Egy dobás legfeljebb {max} részből állhat, például 2d6+1d4+3.',
    error_keep = 'Tarts meg vagy dobj el 1 és {count} közötti számú kockát.',
    error_cooldown = 'Várj egy kicsit, mielőtt újra dobsz.',
    error_permission = 'Nincs jogosultságod kockával dobni.',

    -- Chat command suggestions.
    suggest_roll = 'Dobj kockával, hogy mindenki lássa a közelben',
    suggest_roll_param = 'dobás',
    suggest_roll_param_help = 'Például d20, 2d6+3, 4d6kh3, adv, dis, fate, coin vagy 1-100',
    suggest_help = 'Megmutatja, mit tud a /{roll}',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: mit ért a /{roll}',
    help_default = '/{roll}  dob: {default}',
    help_dice = '/{roll} d20  / 3d6  kockával dob',
    help_math = '/{roll} 2d6+3  összead vagy kivon, legfeljebb {terms} részt (például 2d6+1d4-1)',
    help_percentile = '/{roll} d%  százalékos kockával dob (1-100)',
    help_keep = '/{roll} 4d6kh3  megtartja a 3 legnagyobbat (kl a legkisebbeket; dh, dl eldobja a legnagyobbat, legkisebbet)',
    help_advantage = '/{roll} adv  / dis  2d20-szal dob előnnyel vagy hátránnyal',
    help_fate = '/{roll} fate  / 4dF  Fate kockákkal dob (mindegyik -, 0 vagy +)',
    help_coin = '/{roll} coin  feldob egy érmét',
    help_range = '/{roll} 100  / 5-50  számot választ egy tartományból',
    help_footer = 'Az eldobott kockák (zárójelben) látszanak. A {distance} méteren belüli játékosok látják a dobásod.',
}
