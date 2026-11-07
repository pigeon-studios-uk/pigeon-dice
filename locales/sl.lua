--[[
    Pigeon Dice: Slovenian (Slovenščina).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'sl'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.sl = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} vrže {label}: {total}  {detail}',
    chat_range = '* {name} izbere število od {low} do {high}: {total}',
    chat_coin = '* {name} vrže kovanec: {result}',
    chat_critical = ' (naravna 20!)',
    chat_fumble = ' (naravna 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Kovanec: {result}',

    heads = 'Cifra',
    tails = 'Grb',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Tega meta ne razumem. Vpiši /{help} za primere.',
    error_disabled = 'Ta vrsta meta je na tem strežniku izklopljena.',
    error_range_small = 'Razpon potrebuje dve različni števili, npr. 1-100.',
    error_range_large = 'Števila v razponu so lahko največ {max}.',
    error_sides = 'Kocke imajo lahko od 2 do {max} ploskev.',
    error_too_many_dice = 'Naenkrat lahko vržeš največ {max} kock.',
    error_too_many_terms = 'Met ima lahko največ {max} delov, npr. 2d6+1d4+3.',
    error_keep = 'Obdrži ali zavrzi od 1 do {count} kock.',
    error_cooldown = 'Počakaj trenutek, preden znova vržeš.',
    error_permission = 'Nimaš dovoljenja za metanje kock.',

    -- Chat command suggestions.
    suggest_roll = 'Vrzi kocke, da jih vidijo vsi v bližini',
    suggest_roll_param = 'met',
    suggest_roll_param_help = 'Npr. d20, 2d6+3, 4d6kh3, adv, dis, fate, coin ali 1-100',
    suggest_help = 'Pokaži vse, kar zna /{roll}',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: kaj razume /{roll}',
    help_default = '/{roll}  vrže {default}',
    help_dice = '/{roll} d20  / 3d6  vrže kocke',
    help_math = '/{roll} 2d6+3  sešteje ali odšteje, največ {terms} delov (npr. 2d6+1d4-1)',
    help_percentile = '/{roll} d%  vrže odstotno kocko (1-100)',
    help_keep = '/{roll} 4d6kh3  obdrži 3 najvišje (kl obdrži najnižje; dh, dl zavržeta najvišjo, najnižjo)',
    help_advantage = '/{roll} adv  / dis  vrže 2d20 s prednostjo ali slabostjo',
    help_fate = '/{roll} fate  / 4dF  vrže kocke Fate (vsaka -, 0 ali +)',
    help_coin = '/{roll} coin  vrže kovanec',
    help_range = '/{roll} 100  / 5-50  izbere število iz razpona',
    help_footer = 'Zavržene kocke so v (oklepajih). Igralci v razdalji {distance} metrov vidijo tvoj met.',
}
