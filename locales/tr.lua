--[[
    Pigeon Dice: Turkish (Türkçe).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'tr'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.tr = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} {label} atıyor: {total}  {detail}',
    chat_range = '* {name} {low} ile {high} arasında bir sayı seçiyor: {total}',
    chat_coin = '* {name} yazı tura atıyor: {result}',
    chat_critical = ' (doğal 20!)',
    chat_fumble = ' (doğal 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Yazı tura: {result}',

    heads = 'Tura',
    tails = 'Yazı',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Bu atışı anlamadım. Örnekleri görmek için /{help} yaz.',
    error_disabled = 'Bu tür atış bu sunucuda kapalı.',
    error_range_small = 'Bir aralık için iki farklı sayı gerekir, örneğin 1-100.',
    error_range_large = 'Aralıktaki sayılar en fazla {max} olabilir.',
    error_sides = 'Zarların 2 ile {max} arasında yüzü olabilir.',
    error_too_many_dice = 'Aynı anda en fazla {max} zar atabilirsin.',
    error_too_many_terms = 'Bir atış en fazla {max} parçadan oluşabilir, örneğin 2d6+1d4+3.',
    error_keep = '1 ile {count} arasında zar tut ya da at.',
    error_cooldown = 'Tekrar atmadan önce biraz bekle.',
    error_permission = 'Zar atma iznin yok.',

    -- Chat command suggestions.
    suggest_roll = 'Yakındaki herkesin göreceği şekilde zar at',
    suggest_roll_param = 'atış',
    suggest_roll_param_help = 'Örneğin d20, 2d6+3, 4d6kh3, adv, dis, fate, coin veya 1-100',
    suggest_help = '/{roll} komutunun yapabildiği her şeyi göster',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: /{roll} neleri anlar',
    help_default = '/{roll}  atar: {default}',
    help_dice = '/{roll} d20  / 3d6  zar atar',
    help_math = '/{roll} 2d6+3  toplar veya çıkarır, en fazla {terms} parça (örneğin 2d6+1d4-1)',
    help_percentile = '/{roll} d%  yüzdelik zar atar (1-100)',
    help_keep = '/{roll} 4d6kh3  en yüksek 3 zarı tutar (kl en düşükleri tutar; dh, dl en yükseği, en düşüğü atar)',
    help_advantage = '/{roll} adv  / dis  avantajlı veya dezavantajlı 2d20 atar',
    help_fate = '/{roll} fate  / 4dF  Fate zarları atar (her biri -, 0 veya +)',
    help_coin = '/{roll} coin  yazı tura atar',
    help_range = '/{roll} 100  / 5-50  bir aralıktan sayı seçer',
    help_footer = 'Atılan zarlar (parantez) içinde gösterilir. {distance} metre içindeki oyuncular atışını görür.',
}
