--[[
    Tests for server/dice.lua.

    Run from the repository root with Lua 5.4:
        lua tests/dice.test.lua
]]

local Dice = dofile('server/dice.lua')

local LIMITS = {
    default = '1d20', maxDice = 20, maxSides = 1000, maxTerms = 5, maxRange = 1000000,
    allow = { coin = true, fate = true, range = true, keep = true, advantage = true },
}

local passed, failed = 0, 0

local function check(name, ok, detail)
    if ok then
        passed = passed + 1
    else
        failed = failed + 1
        io.write(('  \27[31mFAIL\27[0m  %s%s\n'):format(name, detail and ('\n          ' .. detail) or ''))
    end
end

--- A random source that returns the given values in order, and checks each request is within bounds.
local function sequence(values)
    local i = 0
    return function(low, high)
        i = i + 1
        local value = values[i]
        assert(value, 'ran out of scripted values')
        assert(value >= low and value <= high, ('scripted %d outside %d..%d'):format(value, low, high))
        return value
    end
end

local function parses(input, label, limits)
    local request, err = Dice.parse(input, limits or LIMITS)
    check(('parse %q -> %s'):format(input, label), request and request.label == label,
        request and ('got label ' .. tostring(request.label)) or ('error ' .. tostring(err)))
    return request
end

local function rejects(input, key, limits)
    local request, err = Dice.parse(input, limits or LIMITS)
    check(('reject %q (%s)'):format(input, key), request == nil and err == key,
        ('got %s / %s'):format(request and request.label or 'nil', tostring(err)))
end

local function rolls(input, values, total, detail, natural)
    local request = Dice.parse(input, LIMITS)
    if not request then return check(('roll %q'):format(input), false, 'did not parse') end
    local result = Dice.roll(request, sequence(values))
    check(('roll %q = %s'):format(input, tostring(total)),
        result.total == total and result.detail == detail and result.natural == natural,
        ('got total %s, detail %s, natural %s'):format(tostring(result.total), tostring(result.detail), tostring(result.natural)))
end

io.write('Pigeon Dice engine tests\n')

-- Parsing
parses('', '1d20')
parses('   ', '1d20')
parses('d20', '1d20')
parses('D20', '1d20')
parses('3d6', '3d6')
parses('2d6+3', '2d6+3')
parses('2d6 + 3', '2d6+3')
parses('2d6-1', '2d6-1')
parses('2d6+1d4+3', '2d6+1d4+3')
parses('-2+1d6', '-2+1d6')
parses('d%', '1d100')
parses('2d%', '2d100')
parses('4d6kh3', '4d6kh3')
parses('4d6k3', '4d6kh3')
parses('4d6kl1', '4d6kl1')
parses('4d6dl1', '4d6dl1')
parses('4d6dh1', '4d6dh1')
parses('adv', '2d20kh1')
parses('advantage', '2d20kh1')
parses('dis', '2d20kl1')
parses('fate', '4dF')
parses('4df', '4dF')
parses('6dF', '6dF')
parses('coin', 'coin')
parses('flip', 'coin')
parses('100', '1-100')
parses('5-50', '5-50')
parses('50-5', '5-50')
parses('-10-10', '-10-10')
parses('between 1 500', '1-500')
parses('1 - 500', '1-500')
parses('', '2d6', { default = '2d6', allow = {} })

-- Rejections
rejects('banana', 'invalid')
rejects('2d', 'invalid')
rejects('d', 'invalid')
parses('3', '1-3')
rejects('1', 'range_small')
rejects('5-5', 'range_small')
rejects('0d6', 'invalid')
rejects('2d1', 'sides')
rejects('1d1001', 'sides')
rejects('21d6', 'too_many_dice')
rejects('10d6+11d6', 'too_many_dice')
rejects('1d4+1d4+1d4+1d4+1d4+1d4', 'too_many_terms')
rejects('4d6kh5', 'keep')
rejects('4d6kh0', 'keep')
rejects('4d6dl4', 'keep')
rejects('2d6kh', 'invalid')
rejects('2d6x3', 'invalid')
rejects('2d6++3', 'invalid')
rejects('2d6+', 'invalid')
rejects('3+4', 'invalid')
rejects('1-9999999', 'range_large')
rejects(string.rep('1d6+', 20) .. '1', 'invalid')
rejects('2d6;quit', 'invalid')
rejects('<b>2d6</b>', 'invalid')
rejects('coin', 'disabled', { allow = { coin = false } })
rejects('fate', 'disabled', { allow = { fate = false } })
rejects('adv', 'disabled', { allow = { advantage = false } })
rejects('100', 'disabled', { allow = { range = false } })
rejects('4d6kh3', 'disabled', { allow = { keep = false } })
parses('adv', '2d20kh1', { allow = { keep = false } })

-- Rolling
rolls('1d20', { 14 }, 14, '[14]', nil)
rolls('1d20', { 20 }, 20, '[20]', 'critical')
rolls('1d20', { 1 }, 1, '[1]', 'fumble')
rolls('3d6', { 2, 5, 6 }, 13, '[2, 5, 6]', nil)
rolls('2d6+3', { 4, 5 }, 12, '[4, 5] + 3', nil)
rolls('2d6-1', { 1, 1 }, 1, '[1, 1] - 1', nil)
rolls('2d6+1d4+3', { 6, 6, 4 }, 19, '[6, 6] + [4] + 3', nil)
rolls('-2+1d6', { 3 }, 1, '- 2 + [3]', nil)
rolls('d%', { 73 }, 73, '[73]', nil)
rolls('4d6kh3', { 1, 6, 4, 5 }, 15, '[(1), 6, 4, 5]', nil)
rolls('4d6dl1', { 3, 3, 2, 6 }, 12, '[3, 3, (2), 6]', nil)
rolls('4d6kl1', { 3, 3, 2, 6 }, 2, '[(3), (3), 2, (6)]', nil)
rolls('4d6dh1', { 6, 6, 2, 1 }, 9, '[6, (6), 2, 1]', nil)
rolls('adv', { 7, 20 }, 20, '[(7), 20]', 'critical')
rolls('dis', { 1, 15 }, 1, '[1, (15)]', 'fumble')
rolls('adv', { 9, 12 }, 12, '[(9), 12]', nil)
rolls('fate', { 1, -1, 0, 1 }, 1, '[+, -, 0, +]', nil)
rolls('2d20', { 20, 20 }, 40, '[20, 20]', nil)

-- Coin and range
do
    local coin = Dice.roll(Dice.parse('coin', LIMITS), sequence({ 1 }))
    check('coin 1 = heads', coin.total == 'heads' and coin.heads == true)
    coin = Dice.roll(Dice.parse('coin', LIMITS), sequence({ 2 }))
    check('coin 2 = tails', coin.total == 'tails' and coin.heads == false)
    local range = Dice.roll(Dice.parse('between 5 50', LIMITS), sequence({ 37 }))
    check('range roll uses the range bounds', range.total == 37 and range.label == '5-50')
end

-- Real randomness stays in bounds and covers every face.
do
    local request = Dice.parse('1d6', LIMITS)
    local seen, ok = {}, true
    for _ = 1, 6000 do
        local value = Dice.roll(request).total
        if value < 1 or value > 6 then ok = false end
        seen[value] = (seen[value] or 0) + 1
    end
    local all = true
    for face = 1, 6 do if not seen[face] or seen[face] < 800 then all = false end end
    check('6000 real d6 rolls stay in 1..6', ok)
    check('6000 real d6 rolls hit every face roughly evenly', all)

    local fate = Dice.parse('4df', LIMITS)
    local fateOk = true
    for _ = 1, 2000 do
        local total = Dice.roll(fate).total
        if total < -4 or total > 4 then fateOk = false end
    end
    check('2000 real 4dF rolls stay in -4..4', fateOk)
end

check('engine is exposed as PigeonDice', PigeonDice == Dice)

io.write(('%d passed, %d failed\n'):format(passed, failed))
os.exit(failed == 0 and 0 or 1)
