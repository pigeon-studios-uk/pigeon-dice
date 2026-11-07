--[[
    Pigeon Dice: Indonesian (Bahasa Indonesia).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'id'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.id = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} melempar {label}: {total}  {detail}',
    chat_range = '* {name} memilih angka dari {low} sampai {high}: {total}',
    chat_coin = '* {name} melempar koin: {result}',
    chat_critical = ' (20 natural!)',
    chat_fumble = ' (1 natural)',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = 'Koin: {result}',

    heads = 'Gambar',
    tails = 'Angka',

    -- Mistakes, shown only to the roller.
    title = 'Dice',
    error_invalid = 'Aku tidak mengerti lemparan itu. Ketik /{help} untuk melihat contoh.',
    error_disabled = 'Jenis lemparan itu dimatikan di server ini.',
    error_range_small = 'Rentang butuh dua angka berbeda, seperti 1-100.',
    error_range_large = 'Angka dalam rentang bisa sampai {max}.',
    error_sides = 'Dadu bisa punya 2 sampai {max} sisi.',
    error_too_many_dice = 'Kamu bisa melempar sampai {max} dadu sekaligus.',
    error_too_many_terms = 'Lemparan bisa punya sampai {max} bagian, seperti 2d6+1d4+3.',
    error_keep = 'Simpan atau buang sejumlah dadu antara 1 dan {count}.',
    error_cooldown = 'Tunggu sebentar sebelum melempar lagi.',
    error_permission = 'Kamu tidak punya izin untuk melempar dadu.',

    -- Chat command suggestions.
    suggest_roll = 'Lempar dadu agar semua orang di dekatmu melihat',
    suggest_roll_param = 'lemparan',
    suggest_roll_param_help = 'Seperti d20, 2d6+3, 4d6kh3, adv, dis, fate, coin, atau 1-100',
    suggest_help = 'Tampilkan semua yang bisa dilakukan /{roll}',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice: yang dimengerti /{roll}',
    help_default = '/{roll}  melempar {default}',
    help_dice = '/{roll} d20  / 3d6  melempar dadu',
    help_math = '/{roll} 2d6+3  menambah atau mengurangi, sampai {terms} bagian (seperti 2d6+1d4-1)',
    help_percentile = '/{roll} d%  melempar dadu persentase (1-100)',
    help_keep = '/{roll} 4d6kh3  menyimpan 3 tertinggi (kl menyimpan terendah; dh, dl membuang tertinggi, terendah)',
    help_advantage = '/{roll} adv  / dis  melempar 2d20 dengan keuntungan atau kerugian',
    help_fate = '/{roll} fate  / 4dF  melempar dadu Fate (masing-masing -, 0, atau +)',
    help_coin = '/{roll} coin  melempar koin',
    help_range = '/{roll} 100  / 5-50  memilih angka dalam rentang',
    help_footer = 'Dadu yang dibuang ditampilkan dalam (kurung). Pemain dalam jarak {distance} meter melihat lemparanmu.',
}
