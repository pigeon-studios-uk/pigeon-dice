--[[
    Pigeon Dice: Simplified Chinese (简体中文).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'zh-cn'
    to use it, or leave it on 'auto' and set ox_lib's language.
    Keep words in {curly brackets} exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales['zh-cn'] = {
    -- Shown in chat to everyone nearby. {name} is the roller.
    chat_roll = '* {name} 掷出 {label}: {total}  {detail}',
    chat_range = '* {name} 从 {low} 到 {high} 中选了一个数: {total}',
    chat_coin = '* {name} 抛了一枚硬币: {result}',
    chat_critical = '（天然 20！）',
    chat_fumble = '（天然 1）',

    -- Shown above the roller's head. GTA's fonts only support plain text.
    float_roll = '{label}: {total}',
    float_range = '{low}-{high}: {total}',
    float_coin = '硬币: {result}',

    heads = '正面',
    tails = '反面',

    -- Mistakes, shown only to the roller.
    title = '骰子',
    error_invalid = '我看不懂这个掷骰。输入 /{help} 查看示例。',
    error_disabled = '这个服务器关闭了这种掷骰。',
    error_range_small = '范围需要两个不同的数字，例如 1-100。',
    error_range_large = '范围内的数字最大为 {max}。',
    error_sides = '骰子可以有 2 到 {max} 面。',
    error_too_many_dice = '一次最多可以掷 {max} 个骰子。',
    error_too_many_terms = '一次掷骰最多可以有 {max} 个部分，例如 2d6+1d4+3。',
    error_keep = '保留或去掉 1 到 {count} 个骰子。',
    error_cooldown = '请稍等片刻再掷。',
    error_permission = '你没有掷骰子的权限。',

    -- Chat command suggestions.
    suggest_roll = '掷骰子，让附近的人都能看到',
    suggest_roll_param = '掷骰',
    suggest_roll_param_help = '例如 d20、2d6+3、4d6kh3、adv、dis、fate、coin 或 1-100',
    suggest_help = '显示 /{roll} 能做的所有事情',

    -- /rollhelp. Lines for roll types the server has turned off aren't shown.
    help_title = 'Pigeon Dice：/{roll} 能识别的写法',
    help_default = '/{roll}  掷 {default}',
    help_dice = '/{roll} d20  / 3d6  掷骰子',
    help_math = '/{roll} 2d6+3  加或减，最多 {terms} 个部分（例如 2d6+1d4-1）',
    help_percentile = '/{roll} d%  掷一个百分骰（1-100）',
    help_keep = '/{roll} 4d6kh3  保留最高的 3 个（kl 保留最低的；dh、dl 去掉最高、最低的）',
    help_advantage = '/{roll} adv  / dis  以优势或劣势掷 2d20',
    help_fate = '/{roll} fate  / 4dF  掷 Fate 骰（每个为 -、0 或 +）',
    help_coin = '/{roll} coin  抛硬币',
    help_range = '/{roll} 100  / 5-50  在范围内选一个数',
    help_footer = '被去掉的骰子显示在（括号）里。{distance} 米内的玩家都能看到你的掷骰。',
}
