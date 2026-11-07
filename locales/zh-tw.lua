--[[
    Pigeon Dice: Traditional Chinese (繁體中文).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'zh-tw'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales['zh-tw'] = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} 擲出 {label}: {total}  {detail}',
    chat_range = '* {name} 從 {low} 到 {high} 中選了一個數: {total}',
    chat_coin = '* {name} 拋了一枚硬幣: {result}',
    chat_critical = '（天然 20！）',
    chat_fumble = '（天然 1）',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = '硬幣: {result}',

    heads = '正面',
    tails = '反面',

    -- Mistakes, shown only to the roller.
    title = '骰子',
    error_invalid = '我看不懂這個擲骰。輸入 /{help} 查看範例。',
    error_disabled = '這個伺服器關閉了這種擲骰。',
    error_range_small = '範圍需要兩個不同的數字，例如 1-100。',
    error_range_large = '範圍內的數字最大為 {max}。',
    error_sides = '骰子可以有 2 到 {max} 面。',
    error_too_many_dice = '一次最多可以擲 {max} 顆骰子。',
    error_too_many_terms = '一次擲骰最多可以有 {max} 個部分，例如 2d6+1d4+3。',
    error_keep = '保留或去掉 1 到 {count} 顆骰子。',
    error_cooldown = '請稍等片刻再擲。',
    error_permission = '你沒有擲骰子的權限。',

    -- Chat command suggestions.
    suggest_roll = '擲骰子，讓附近的人都能看到',
    suggest_roll_param = '擲骰',
    suggest_roll_param_help = '例如 d20、2d6+3、4d6kh3、adv、dis、fate、coin 或 1-100',
    suggest_help = '顯示 /{roll} 能做的所有事情',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice：/{roll} 能識別的寫法',
    help_default = '/{roll}  擲 {default}',
    help_dice = '/{roll} d20  / 3d6  擲骰子',
    help_math = '/{roll} 2d6+3  加或減，最多 {terms} 個部分（例如 2d6+1d4-1）',
    help_percentile = '/{roll} d%  擲一顆百分骰（1-100）',
    help_keep = '/{roll} 4d6kh3  保留最高的 3 顆（kl 保留最低的；dh、dl 去掉最高、最低的）',
    help_advantage = '/{roll} adv  / dis  以優勢或劣勢擲 2d20',
    help_fate = '/{roll} fate  / 4dF  擲 Fate 骰（每顆為 -、0 或 +）',
    help_coin = '/{roll} coin  拋硬幣',
    help_range = '/{roll} 100  / 5-50  在範圍內選一個數',
    help_footer = '被去掉的骰子顯示在（括號）裡。{distance} 公尺內的玩家都能看到你的擲骰。',
}
