require('consts')

local push = require('deps.push')

love.graphics.setDefaultFilter('nearest', 'nearest')

local sprites = require('sprites')

local StateMachine = require('state_machine')
local StartScene = require('scenes.start')

local stateMachine = StateMachine.new({
    start = StartScene.new
})

function love.load()
    love.window.setTitle('BREAKOUT')

    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        resizable = true,
        fullscreen = false
    })

    stateMachine:change('start')
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    stateMachine:keypressed(key)
end

function love.update(dt)
    stateMachine:update(dt)
end

function love.draw()
    push:start()

    local bgWidth = sprites.background:getWidth()
    local bgHeight = sprites.background:getHeight()

    love.graphics.draw(
        sprites.background,
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

    stateMachine:render()

    push:finish()
end
