local fs = {}

-- splits on first occurrence of ch
-- split('hurt.wav', '.') = 'hurt', 'wav'
function fs.split(str, ch)
    local where = 0
    for i = 1, #str do
        if ch == str:sub(i, i) then
            where = i
            break
        end
    end
    return str:sub(1, where - 1), str:sub(where + 1, #str)
end

function fs.dirToTable(dir, cb)
    local files = {}
    -- no recursion cause our assets are flat like earth
    for _, file in ipairs(love.filesystem.getDirectoryItems(dir)) do
        local without_ext, _ = fs.split(file, '.')
        files[without_ext] = cb(file)
    end
    return files
end

function fs.loadHighScores()
    love.filesystem.setIdentity('breakout2')

    if not love.filesystem.getInfo('breakout.lst') then
        local scores = ''

        for i = 10, 1, -1 do
            scores = scores .. 'EVA,'
            scores = scores .. tostring(i * 1000) .. '\n'
        end

        love.filesystem.write('breakout.lst', scores)
    end

    local scores = {}

    for line in love.filesystem.lines('breakout.lst') do
        local name, score = fs.split(line, ',')
        table.insert(scores, { name = name, score = tonumber(score) })
    end

    return scores
end

function fs.saveHighScores(highScores)
    love.filesystem.setIdentity('breakout2')

    local scoresStr = ''
    for _, pair in pairs(highScores) do
        scoresStr = scoresStr .. pair.name
        scoresStr = scoresStr .. ','
        scoresStr = scoresStr .. tostring(pair.score)
        scoresStr = scoresStr .. '\n'
    end

    love.filesystem.write('breakout.lst', scoresStr)
end

return fs
