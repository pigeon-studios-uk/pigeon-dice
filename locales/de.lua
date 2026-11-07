--[[
    Pigeon Dice: German (Deutsch).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'de'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.de = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} würfelt {label}: {total}  {detail}',
    chat_range = '* {name} wählt eine Zahl von {low} bis {high}: {total}',
    chat_coin = '* {name} wirft eine Münze: {result}',
    chat_critical = ' (natürliche 20!)',
    chat_fumble = ' (natürliche 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Münze: {result}',

    heads = 'Kopf',
    tails = 'Zahl',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Diesen Wurf verstehe ich nicht. Gib /{help} ein, um Beispiele zu sehen.',
    error_disabled = 'Diese Art von Wurf ist auf diesem Server ausgeschaltet.',
    error_range_small = 'Ein Bereich braucht zwei verschiedene Zahlen, etwa 1-100.',
    error_range_large = 'Zahlen in einem Bereich dürfen höchstens {max} sein.',
    error_sides = 'Würfel können 2 bis {max} Seiten haben.',
    error_too_many_dice = 'Du kannst höchstens {max} Würfel auf einmal werfen.',
    error_too_many_terms = 'Ein Wurf kann höchstens {max} Teile haben, etwa 2d6+1d4+3.',
    error_keep = 'Behalte oder verwirf eine Anzahl Würfel zwischen 1 und {count}.',
    error_cooldown = 'Warte kurz, bevor du wieder würfelst.',
    error_permission = 'Du hast keine Berechtigung zum Würfeln.',

    -- Chat command suggestions.
    suggest_roll = 'Würfle, damit alle in der Nähe es sehen',
    suggest_roll_param = 'wurf',
    suggest_roll_param_help = 'Etwa d20, 2d6+3, 4d6kh3, adv, dis, fate, coin oder 1-100',
    suggest_help = 'Zeigt alles, was /{roll} kann',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: was /{roll} versteht',
    help_default = '/{roll}  würfelt {default}',
    help_dice = '/{roll} d20  / 3d6  wirft Würfel',
    help_math = '/{roll} 2d6+3  addiert oder subtrahiert, bis zu {terms} Teile (etwa 2d6+1d4-1)',
    help_percentile = '/{roll} d%  wirft einen Prozentwürfel (1-100)',
    help_keep = '/{roll} 4d6kh3  behält die höchsten 3 (kl behält die niedrigsten; dh, dl verwerfen höchste, niedrigste)',
    help_advantage = '/{roll} adv  / dis  wirft 2d20 mit Vorteil oder Nachteil',
    help_fate = '/{roll} fate  / 4dF  wirft Fate-Würfel (jeder -, 0 oder +)',
    help_coin = '/{roll} coin  wirft eine Münze',
    help_range = '/{roll} 100  / 5-50  wählt eine Zahl aus einem Bereich',
    help_footer = 'Verworfene Würfel stehen in (Klammern). Spieler im Umkreis von {distance} Metern sehen deinen Wurf.',
}
