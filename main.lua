require('consts')

local push = require('deps.push')

love.graphics.setDefaultFilter('nearest', 'nearest')

local sprites = require('sprites')
local fonts = require('fonts')

local time = 0
local title = 'breakout'

function love.load()
    love.window.setTitle(string.upper(title))

    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        resizable = true,
        fullscreen = false
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    time = time + dt
end

local function drawTitle()
    local font = fonts['large']
    love.graphics.setFont(font)

    local startWidth = (GAME_WIDTH - font:getWidth(title)) / 2
    local chHeight = font:getHeight()
    for i = 1, #title do
        local color = RAINBOW[i]
        love.graphics.setColor(color.r, color.g, color.b, 255)

        local ch = title:sub(i, i)
        local chWidth = font:getWidth(ch)
        startWidth = startWidth + chWidth / 2
        love.graphics.print(ch, startWidth, GAME_HEIGHT / 4 + math.sin(time * 5 + 20 * i) * 10, 0, 1, 1, chWidth / 2, chHeight / 2)
        startWidth = startWidth + chWidth / 2
    end
end

function love.draw()
    push:start()

    local bgWidth = sprites['background']:getWidth()
    local bgHeight = sprites['background']:getHeight()

    love.graphics.draw(
        sprites['background'],
        -- x, y
        0, 0,
        -- no rotation
        0,
        -- adjust proportions
        -- our background is smaller than
        -- virtual width/height
        GAME_WIDTH / (bgWidth - 1),
        GAME_HEIGHT / (bgHeight - 1)
    )

    drawTitle()

    push:finish()
end
