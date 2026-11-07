--[[
    Pigeon Dice: Croatian (Hrvatski).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'hr'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.hr = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} baca {label}: {total}  {detail}',
    chat_range = '* {name} bira broj od {low} do {high}: {total}',
    chat_coin = '* {name} baca novčić: {result}',
    chat_critical = ' (prirodna 20!)',
    chat_fumble = ' (prirodna 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Novčić: {result}',

    heads = 'Glava',
    tails = 'Pismo',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Ne razumijem to bacanje. Upiši /{help} za primjere.',
    error_disabled = 'Ta vrsta bacanja isključena je na ovom serveru.',
    error_range_small = 'Raspon treba dva različita broja, npr. 1-100.',
    error_range_large = 'Brojevi u rasponu mogu biti najviše {max}.',
    error_sides = 'Kocke mogu imati od 2 do {max} strana.',
    error_too_many_dice = 'Odjednom možeš baciti najviše {max} kocki.',
    error_too_many_terms = 'Bacanje može imati najviše {max} dijelova, npr. 2d6+1d4+3.',
    error_keep = 'Zadrži ili odbaci broj kocki između 1 i {count}.',
    error_cooldown = 'Pričekaj trenutak prije ponovnog bacanja.',
    error_permission = 'Nemaš dopuštenje bacati kocke.',

    -- Chat command suggestions.
    suggest_roll = 'Baci kocke da ih vide svi u blizini',
    suggest_roll_param = 'bacanje',
    suggest_roll_param_help = 'Npr. d20, 2d6+3, 4d6kh3, adv, dis, fate, coin ili 1-100',
    suggest_help = 'Prikaži sve što /{roll} može',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: što /{roll} razumije',
    help_default = '/{roll}  baca {default}',
    help_dice = '/{roll} d20  / 3d6  baca kocke',
    help_math = '/{roll} 2d6+3  zbraja ili oduzima, najviše {terms} dijelova (npr. 2d6+1d4-1)',
    help_percentile = '/{roll} d%  baca postotnu kocku (1-100)',
    help_keep = '/{roll} 4d6kh3  zadržava 3 najviše (kl zadržava najniže; dh, dl odbacuju najvišu, najnižu)',
    help_advantage = '/{roll} adv  / dis  baca 2d20 s prednošću ili nedostatkom',
    help_fate = '/{roll} fate  / 4dF  baca Fate kocke (svaka -, 0 ili +)',
    help_coin = '/{roll} coin  baca novčić',
    help_range = '/{roll} 100  / 5-50  bira broj u rasponu',
    help_footer = 'Odbačene kocke prikazane su u (zagradama). Igrači unutar {distance} metara vide tvoje bacanje.',
}
