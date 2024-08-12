-- common render functions

local fonts = require('fonts')
local images = require('images')
local sprites = require('sprites')

local function renderScore(score)
    love.graphics.setFont(fonts.small)
    love.graphics.print('score:', GAME_WIDTH - 60, 5)
    love.graphics.printf(tostring(score), GAME_WIDTH - 50, 5, 40, 'right')
end

local function renderHealth(health)
    local healthX = GAME_WIDTH - 100

    for _ = 1, health do
        love.graphics.draw(images.hearts, sprites.hearts[1], healthX, 4)
        healthX = healthX - 11
    end

    for _ = 1, 3 - health do
        love.graphics.draw(images.hearts, sprites.hearts[2], healthX, 4)
        healthX = healthX - 11
    end
end

return {
    score = renderScore,
    health = renderHealth,
}
