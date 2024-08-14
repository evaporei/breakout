local BaseScene = require('scenes.base')
local Paddle = require('paddle')
local LevelMaker = require('level_maker')

local images = require('images')
local sprites = require('sprites')
local sounds = require('sounds')
local fonts = require('fonts')

local PaddleSelectScene = {}
setmetatable(PaddleSelectScene, { __index = BaseScene })

function PaddleSelectScene.new(params)
    local self = {}

    self.stateMachine = params.stateMachine
    self.highScores = params.highScores

    self.currentPaddle = 1

    setmetatable(self, { __index = PaddleSelectScene })
    return self
end

function PaddleSelectScene:keypressed(key)
    if key == 'left' then
        if self.currentPaddle == 1 then
            sounds['no-select']:play()
        else
            sounds['select']:play()
            self.currentPaddle = self.currentPaddle - 1
        end
    elseif key == 'right' then
        if self.currentPaddle == 4 then
            sounds['no-select']:play()
        else
            sounds['select']:play()
            self.currentPaddle = self.currentPaddle + 1
        end
    elseif key == 'enter' or key == 'return' then
        self.stateMachine:change{'serve',
            paddle = Paddle.new(self.currentPaddle),
            bricks = LevelMaker.createMap(1),
            health = 3,
            score = 0,
            level = 1,
            highScores = self.highScores,
        }
    elseif key == 'escape' then
        love.event.quit()
    end
end

function PaddleSelectScene:render()
    love.graphics.setFont(fonts.medium)
    love.graphics.printf('select your paddle with left and right!', 0, GAME_HEIGHT / 4, GAME_WIDTH, 'center')
    love.graphics.setFont(fonts.small)
    love.graphics.printf("press 'Enter' to continue", 0, GAME_HEIGHT / 3, GAME_WIDTH, 'center')

    -- shadow arrow if first
    if self.currentPaddle == 1 then
        love.graphics.setColor(40/255, 40/255, 40/255, 128/255)
    end

    love.graphics.draw(images.arrows, sprites.arrows[1], GAME_WIDTH / 4 - 24, GAME_HEIGHT / 4 * 3)

    love.graphics.setColor(1, 1, 1, 1)

    -- shadow arrow if last
    if self.currentPaddle == 4 then
        love.graphics.setColor(40/255, 40/255, 40/255, 128/255)
    end

    love.graphics.draw(images.arrows, sprites.arrows[2], GAME_WIDTH / 4 * 3, GAME_HEIGHT / 4 * 3)

    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(images.breakout, sprites.paddles[2 + 4 * (self.currentPaddle - 1)], GAME_WIDTH / 2 - 32, GAME_HEIGHT / 4 * 3)
end

return PaddleSelectScene
