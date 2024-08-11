local BaseScene = require('scenes.base')

local sounds = require('sounds')
local fonts = require('fonts')

local Ball = require('ball')

local ServeScene = {}
setmetatable(ServeScene, { __index = BaseScene })

function ServeScene.new(params)
    local self = {}

    self.stateMachine = params.stateMachine
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score

    self.ball = Ball.new(self.paddle)

    setmetatable(self, { __index = ServeScene })
    return self
end

function ServeScene:keypressed(key)
    if key == 'enter' or key == 'return' then
        self.stateMachine:change{'play',
            paddle = self.paddle,
            bricks = self.bricks,
            ball = self.ball
        }
    end

    if key == 'escape' then
        love.event.quit()
    end
end

function ServeScene:update(dt)
    self.paddle:update(dt)
    self.ball:follow(self.paddle)
end

function ServeScene:render()
    self.paddle:render()
    self.ball:render()
    for _, brick in pairs(self.bricks) do
        brick:render()
    end

    love.graphics.setFont(fonts.medium)
    love.graphics.printf("press 'Enter' to serve!", 0, GAME_HEIGHT / 2, GAME_WIDTH, 'center')
end

return ServeScene
