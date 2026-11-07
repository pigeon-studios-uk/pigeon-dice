--[[
    Pigeon Dice: Estonian (Eesti).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'et'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.et = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} veeretab {label}: {total}  {detail}',
    chat_range = '* {name} valib arvu vahemikus {low} kuni {high}: {total}',
    chat_coin = '* {name} viskab münti: {result}',
    chat_critical = ' (loomulik 20!)',
    chat_fumble = ' (loomulik 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Münt: {result}',

    heads = 'Kiri',
    tails = 'Kull',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Ma ei saa sellest veeretusest aru. Sisesta /{help}, et näha näiteid.',
    error_disabled = 'Seda tüüpi veeretus on selles serveris välja lülitatud.',
    error_range_small = 'Vahemik vajab kaht erinevat arvu, näiteks 1-100.',
    error_range_large = 'Vahemiku arvud võivad olla kuni {max}.',
    error_sides = 'Täringutel võib olla 2 kuni {max} tahku.',
    error_too_many_dice = 'Korraga saad veeretada kuni {max} täringut.',
    error_too_many_terms = 'Veeretusel võib olla kuni {max} osa, näiteks 2d6+1d4+3.',
    error_keep = 'Jäta alles või viska ära 1 kuni {count} täringut.',
    error_cooldown = 'Oota hetk, enne kui uuesti veeretad.',
    error_permission = 'Sul pole õigust täringuid veeretada.',

    -- Chat command suggestions.
    suggest_roll = 'Veereta täringuid nii, et kõik lähedal näevad',
    suggest_roll_param = 'veeretus',
    suggest_roll_param_help = 'Näiteks d20, 2d6+3, 4d6kh3, adv, dis, fate, coin või 1-100',
    suggest_help = 'Näita kõike, mida /{roll} oskab',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: millest /{roll} aru saab',
    help_default = '/{roll}  veeretab {default}',
    help_dice = '/{roll} d20  / 3d6  veeretab täringuid',
    help_math = '/{roll} 2d6+3  liidab või lahutab, kuni {terms} osa (näiteks 2d6+1d4-1)',
    help_percentile = '/{roll} d%  veeretab protsenditäringut (1-100)',
    help_keep = '/{roll} 4d6kh3  jätab alles 3 kõrgeimat (kl jätab madalaimad; dh, dl viskavad ära kõrgeima, madalaima)',
    help_advantage = '/{roll} adv  / dis  veeretab 2d20 eelise või puudusega',
    help_fate = '/{roll} fate  / 4dF  veeretab Fate täringuid (igaüks -, 0 või +)',
    help_coin = '/{roll} coin  viskab münti',
    help_range = '/{roll} 100  / 5-50  valib arvu vahemikust',
    help_footer = 'Äravisatud täringud on (sulgudes). Mängijad {distance} meetri raadiuses näevad sinu veeretust.',
}
