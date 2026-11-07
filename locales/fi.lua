--[[
    Pigeon Dice: Finnish (Suomi).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'fi'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.fi = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} heittää {label}: {total}  {detail}',
    chat_range = '* {name} valitsee luvun väliltä {low}-{high}: {total}',
    chat_coin = '* {name} heittää kolikkoa: {result}',
    chat_critical = ' (luonnollinen 20!)',
    chat_fumble = ' (luonnollinen 1)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Kolikko: {result}',

    heads = 'Kruuna',
    tails = 'Klaava',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'En ymmärrä tätä heittoa. Kirjoita /{help} nähdäksesi esimerkkejä.',
    error_disabled = 'Tämänlainen heitto on poistettu käytöstä tällä palvelimella.',
    error_range_small = 'Väli tarvitsee kaksi eri lukua, esimerkiksi 1-100.',
    error_range_large = 'Välin luvut voivat olla enintään {max}.',
    error_sides = 'Nopissa voi olla 2-{max} sivua.',
    error_too_many_dice = 'Voit heittää enintään {max} noppaa kerralla.',
    error_too_many_terms = 'Heitossa voi olla enintään {max} osaa, esimerkiksi 2d6+1d4+3.',
    error_keep = 'Pidä tai pudota noppia 1-{count} kappaletta.',
    error_cooldown = 'Odota hetki ennen kuin heität uudelleen.',
    error_permission = 'Sinulla ei ole oikeutta heittää noppaa.',

    -- Chat command suggestions.
    suggest_roll = 'Heitä noppaa kaikkien lähellä olevien nähtäväksi',
    suggest_roll_param = 'heitto',
    suggest_roll_param_help = 'Esimerkiksi d20, 2d6+3, 4d6kh3, adv, dis, fate, coin tai 1-100',
    suggest_help = 'Näytä kaikki, mitä /{roll} osaa',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: mitä /{roll} ymmärtää',
    help_default = '/{roll}  heittää {default}',
    help_dice = '/{roll} d20  / 3d6  heittää noppia',
    help_math = '/{roll} 2d6+3  lisää tai vähentää, enintään {terms} osaa (esimerkiksi 2d6+1d4-1)',
    help_percentile = '/{roll} d%  heittää prosenttinopan (1-100)',
    help_keep = '/{roll} 4d6kh3  pitää 3 suurinta (kl pitää pienimmät; dh, dl pudottavat suurimman, pienimmän)',
    help_advantage = '/{roll} adv  / dis  heittää 2d20 edulla tai haitalla',
    help_fate = '/{roll} fate  / 4dF  heittää Fate-noppia (kukin -, 0 tai +)',
    help_coin = '/{roll} coin  heittää kolikkoa',
    help_range = '/{roll} 100  / 5-50  valitsee luvun väliltä',
    help_footer = 'Pudotetut nopat näkyvät (suluissa). Pelaajat {distance} metrin säteellä näkevät heittosi.',
}
