--[[
    Pigeon Dice: dice engine.

    Parses roll expressions and rolls them. Pure Lua with no FiveM calls: the server loads it as the
    PigeonDice table for every roll, and the tests in tests/ run it in plain Lua 5.4.

    Supported input (case-insensitive, spaces ignored):
        (empty)            the configured default, normally 1d20
        d20, 3d6           dice: [count]d<sides>
        d%                 a percentile die (d100)
        2d6+1d4+3          up to Limits.maxTerms dice and numbers, added or subtracted
        4d6kh3, 4d6k3      keep the highest 3 (kl = keep lowest, dh/dl = drop highest/lowest)
        adv, dis           advantage / disadvantage: 2d20 keep highest / lowest
        4df, fate          Fate (Fudge) dice: each is -1, 0 or +1
        coin, flip         heads or tails
        100                a number from 1 to 100
        5-50, between 5 50 a number in a range (negatives allowed)
]]

local Dice = {}

local function trim(text)
    return (text:gsub('^%s+', ''):gsub('%s+$', ''))
end

local function toInt(text)
    local value = tonumber(text)
    if not value or value ~= math.floor(value) then return nil end
    return math.tointeger(value)
end

---------------------------------------------------------------------------
-- Parsing

--- Parses one dice term such as "4d6kh3" (without a sign). Returns a term table or nil.
local function parseDiceTerm(text)
    local count, sides, rest = text:match('^(%d*)d(%d+)(.*)$')
    if not sides then
        count, rest = text:match('^(%d*)d%%(.*)$')
        if count then sides = '100' end
    end
    if not sides then
        local fateCount = text:match('^(%d*)df$')
        if fateCount then
            return { kind = 'fate', count = fateCount == '' and 4 or toInt(fateCount) }
        end
        return nil
    end

    local term = { kind = 'dice', count = count == '' and 1 or toInt(count), sides = toInt(sides) }
    if rest == '' then return term end

    local mode, amount = rest:match('^(k[hl]?)(%d+)$')
    if not mode then mode, amount = rest:match('^(d[hl])(%d+)$') end
    if not mode then return nil end

    term.mode = mode == 'k' and 'kh' or mode
    term.amount = toInt(amount)
    return term
end

--- Splits "2d6+1d4-2" into signed terms. Returns a list or nil.
local function parseExpression(text)
    if text:find('[^%w%%%+%-]') then return nil end
    if not text:match('^[%+%-]?[%w%%]') then return nil end

    local terms = {}
    local pos = 1
    while pos <= #text do
        local sign = 1
        local c = text:sub(pos, pos)
        if c == '+' or c == '-' then
            sign = c == '-' and -1 or 1
            pos = pos + 1
        elseif pos > 1 then
            return nil
        end

        local body = text:match('^[%w%%]+', pos)
        if not body then return nil end
        pos = pos + #body

        local term
        if body:match('^%d+$') then
            term = { kind = 'number', value = toInt(body) }
        else
            term = parseDiceTerm(body)
        end
        if not term then return nil end
        term.sign = sign
        terms[#terms + 1] = term
    end
    return terms
end

--- Parses player input into a roll request.
--- Returns request, or nil plus an error key and its values for the locale.
---@param input string
---@param limits table { maxDice, maxSides, maxTerms, maxRange, default, allow = { coin, fate, range, keep, advantage } }
function Dice.parse(input, limits)
    local text = trim(tostring(input or '')):lower()
    local allow = limits.allow or {}

    if text == '' then text = limits.default or '1d20' end
    if #text > 60 then return nil, 'invalid' end

    if text == 'coin' or text == 'flip' then
        if allow.coin == false then return nil, 'disabled' end
        return { kind = 'coin', label = 'coin' }
    end

    local shortcut = false
    if text == 'adv' or text == 'advantage' then
        if allow.advantage == false then return nil, 'disabled' end
        text, shortcut = '2d20kh1', true
    elseif text == 'dis' or text == 'disadvantage' then
        if allow.advantage == false then return nil, 'disabled' end
        text, shortcut = '2d20kl1', true
    elseif text == 'fate' then
        text = '4df'
    end

    -- Ranges: "100", "5-50", "-10-10", "between 5 50"
    local low, high = text:match('^between%s+(%-?%d+)%s+(%-?%d+)$')
    if not low then low, high = text:match('^(%-?%d+)%s*%-%s*(%-?%d+)$') end
    if not low and text:match('^%d+$') then low, high = '1', text end
    if low then
        if allow.range == false then return nil, 'disabled' end
        low, high = toInt(low), toInt(high)
        if not low or not high then return nil, 'invalid' end
        if low > high then low, high = high, low end
        if low == high then return nil, 'range_small' end
        local maxRange = limits.maxRange or 1000000
        if math.abs(low) > maxRange or math.abs(high) > maxRange then return nil, 'range_large', { max = maxRange } end
        return { kind = 'range', low = low, high = high, label = ('%d-%d'):format(low, high) }
    end

    local terms = parseExpression((text:gsub('%s+', '')))
    if not terms then return nil, 'invalid' end
    if #terms > (limits.maxTerms or 5) then return nil, 'too_many_terms', { max = limits.maxTerms or 5 } end

    local totalDice, hasDice = 0, false
    for _, term in ipairs(terms) do
        if term.kind == 'dice' or term.kind == 'fate' then
            hasDice = true
            if term.kind == 'fate' and allow.fate == false then return nil, 'disabled' end
            if not term.count or term.count < 1 then return nil, 'invalid' end
            totalDice = totalDice + term.count
            if term.kind == 'dice' then
                if not term.sides or term.sides < 2 or term.sides > (limits.maxSides or 1000) then
                    return nil, 'sides', { max = limits.maxSides or 1000 }
                end
                if term.mode then
                    if allow.keep == false and not shortcut then return nil, 'disabled' end
                    local keeps = term.mode == 'kh' or term.mode == 'kl'
                    if not term.amount or term.amount < 1 or (keeps and term.amount > term.count) or (not keeps and term.amount >= term.count) then
                        return nil, 'keep', { count = term.count }
                    end
                end
            end
        elseif not term.value or term.value > (limits.maxRange or 1000000) then
            return nil, 'invalid'
        end
    end
    if not hasDice then return nil, 'invalid' end
    if totalDice > (limits.maxDice or 20) then return nil, 'too_many_dice', { max = limits.maxDice or 20 } end

    return { kind = 'expression', terms = terms, label = Dice.describe(terms) }
end

--- Rebuilds a tidy expression from parsed terms, e.g. "2d6+1d4-2".
function Dice.describe(terms)
    local parts = {}
    for i, term in ipairs(terms) do
        local sign = term.sign < 0 and '-' or (i > 1 and '+' or '')
        local body
        if term.kind == 'number' then
            body = tostring(term.value)
        elseif term.kind == 'fate' then
            body = ('%ddF'):format(term.count)
        else
            body = ('%dd%d'):format(term.count, term.sides)
            if term.mode then body = body .. term.mode .. term.amount end
        end
        parts[#parts + 1] = sign .. body
    end
    return table.concat(parts)
end

---------------------------------------------------------------------------
-- Rolling

--- Rolls a parsed request. `random(low, high)` defaults to math.random.
--- Returns { label, total, detail, kind, natural } where detail is a short breakdown such as "[6, 5, 4, (1)] + 3".
function Dice.roll(request, random)
    random = random or math.random

    if request.kind == 'coin' then
        local heads = random(1, 2) == 1
        return { kind = 'coin', label = 'coin', heads = heads, total = heads and 'heads' or 'tails', detail = nil }
    end

    if request.kind == 'range' then
        return { kind = 'range', label = request.label, total = random(request.low, request.high), detail = nil }
    end

    local total, details = 0, {}
    local single = #request.terms == 1 and request.terms[1].kind == 'dice' and request.terms[1].count == 1 and request.terms[1].sides == 20
    local natural

    for i, term in ipairs(request.terms) do
        local signText = term.sign < 0 and '- ' or (i > 1 and '+ ' or '')

        if term.kind == 'number' then
            total = total + term.sign * term.value
            details[#details + 1] = signText .. term.value
        else
            local rolls = {}
            for n = 1, term.count do
                if term.kind == 'fate' then
                    rolls[n] = { value = random(-1, 1) }
                else
                    rolls[n] = { value = random(1, term.sides) }
                end
            end

            -- Mark dropped dice for keep/drop modifiers, keeping the original roll order for display.
            if term.mode then
                local order = {}
                for n = 1, #rolls do order[n] = n end
                local highestFirst = term.mode == 'kh' or term.mode == 'dl'
                table.sort(order, function(a, b)
                    if rolls[a].value == rolls[b].value then return a < b end
                    if highestFirst then return rolls[a].value > rolls[b].value end
                    return rolls[a].value < rolls[b].value
                end)
                local keep = (term.mode == 'kh' or term.mode == 'kl') and term.amount or (#rolls - term.amount)
                for rank, index in ipairs(order) do
                    rolls[index].dropped = rank > keep
                end
            end

            local subtotal, shown = 0, {}
            for n, roll in ipairs(rolls) do
                if not roll.dropped then subtotal = subtotal + roll.value end
                local text
                if term.kind == 'fate' then
                    text = roll.value > 0 and '+' or (roll.value < 0 and '-' or '0')
                else
                    text = tostring(roll.value)
                end
                shown[n] = roll.dropped and ('(' .. text .. ')') or text
            end
            total = total + term.sign * subtotal
            details[#details + 1] = signText .. '[' .. table.concat(shown, ', ') .. ']'

            if single then natural = rolls[1].value end
        end
    end

    local result = { kind = 'expression', label = request.label, total = total, detail = table.concat(details, ' ') }
    if natural == 20 then result.natural = 'critical' elseif natural == 1 then result.natural = 'fumble' end

    -- Advantage and disadvantage (one d20 term keeping one die) can also crit or fumble on the kept die.
    local only = request.terms[1]
    if #request.terms == 1 and only.kind == 'dice' and only.sides == 20 and only.mode and (only.mode == 'kh' or only.mode == 'kl') and only.amount == 1 then
        if total == 20 then result.natural = 'critical' elseif total == 1 then result.natural = 'fumble' end
    end

    return result
end

PigeonDice = Dice
return Dice
