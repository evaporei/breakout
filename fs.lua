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

return fs
