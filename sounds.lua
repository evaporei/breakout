local base = 'assets/sounds/'

local files = {}

-- splits on first occurrence of ch
-- split('hurt.wav', '.') = 'hurt', 'wav'
local function split(str, ch)
    local where = 0
    for i = 1, #str do
        if ch == str:sub(i, i) then
            where = i
            break
        end
    end
    return str:sub(1, where - 1), str:sub(where + 1, #str)
end

-- no recursion cause sounds are flat like earth
for _, file in ipairs(love.filesystem.getDirectoryItems(base)) do
    local without_ext, _ = split(file, '.')
    files[without_ext] = love.audio.newSource(base .. file, 'static')
end

return files
