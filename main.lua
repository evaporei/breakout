local sounds = require('sounds')

local font = love.graphics.newFont('assets/fonts/font.ttf', 42)

local text = 'breakout'

function love.load()
end

function love.keypressed(key)
    if key == 'enter' or key == 'return' then
        sounds['hurt']:play()
    end
    if key == 'escape' then
        love.event.quit()
    end
end

local time = 0

function love.update(dt)
    time = time + dt
end

-- rainbow
local colors = {
    -- Red
    { r = 0xe8/255, g = 0x14/255, b = 0x16/255 },
    -- Orange
    { r = 0xff/255, g = 0xa5/255, b = 0x00/255 },
    -- Yellow
    { r = 0xfa/255, g = 0xeb/255, b = 0x36/255 },
    -- Green
    { r = 0x79/255, g = 0xc3/255, b = 0x14/255 },
    -- Blue
    { r = 0x48/255, g = 0x7d/255, b = 0xe7/255 },
    -- Indigo
    { r = 0x4b/255, g = 0x36/255, b = 0x9d/255 },
    -- Violet
    { r = 0x70/255, g = 0x36/255, b = 0x9d/255 },
    -- uhh another one
    { r = 0x95/255, g = 0x36/255, b = 0x9d/255 }
}

function love.draw()
    local width, height = love.graphics.getDimensions()

    love.graphics.setFont(font)

    local startWidth = (width - font:getWidth(text)) / 2
    local chHeight = font:getHeight()
    for i = 1, #text do
        local color = colors[i]
        love.graphics.setColor(color.r, color.g, color.b, 255)

        local ch = text:sub(i, i)
        local chWidth = font:getWidth(ch)
        startWidth = startWidth + chWidth / 2
        love.graphics.print(ch, startWidth, height / 4 + math.sin(time * 5 + 20 * i) * 10, 0, 1, 1, chWidth / 2, chHeight / 2)
        startWidth = startWidth + chWidth / 2
    end
end
