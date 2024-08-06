local images = require('images')

local function paddleQuads(atlas)
    local x = 0
    local y = 64 -- there are 4 x 16 sprites above

    local quads = {}

    -- there are 4 groups of 4 quads (small, mid, large and huge)
    for _ = 0, 3 do
        local smallQuad = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        table.insert(quads, smallQuad)

        local mediumQuad = love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions())
        table.insert(quads, mediumQuad)

        local largeQuad = love.graphics.newQuad(x + 96, y, 96, 16, atlas:getDimensions())
        table.insert(quads, largeQuad)

        local hugeQuad = love.graphics.newQuad(x, y + 16, 128, 16, atlas:getDimensions())
        table.insert(quads, hugeQuad)

        x = 0
        y = y + 32
    end

    return quads
end

local function ballQuads(atlas)
    local x, y = 96, 48

    local quads = {}

    -- 4 balls in first row
    for _ = 0, 3 do
        local ball = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        table.insert(quads, ball)
        x = x + 8
    end

    x, y = 96, 56
    -- 3 balls in second row
    for _ = 0, 2 do
        local ball = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        table.insert(quads, ball)
        x = x + 8
    end

    return quads
end

return {
    paddles = paddleQuads(images.breakout),
    balls = ballQuads(images.breakout)
}
