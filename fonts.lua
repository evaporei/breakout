local file = 'assets/fonts/font.ttf'

local function newFont(size)
    return love.graphics.newFont(file, size)
end

return {
    ['small'] = newFont(8),
    ['medium'] = newFont(16),
    ['large'] = newFont(32)
}
