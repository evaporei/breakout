local BaseScene = require('scenes.base')

local sounds = require('sounds')
local fonts = require('fonts')

local Paddle = require('paddle')
local Ball = require('ball')

local PlayScene = {}
setmetatable(PlayScene, { __index = BaseScene })

function PlayScene.new(stateMachine)
    local self = {}

    self.stateMachine = stateMachine

    self.paddle = Paddle.new()
    self.ball = Ball.new(1, self.paddle)
    self.paused = false

    setmetatable(self, { __index = PlayScene })
    return self
end

function PlayScene:keypressed(key)
    if key == 'space' then
        self.paused = not self.paused
        sounds.pause:play()
    elseif key == 'escape' then
        love.event.quit()
    end
end

function PlayScene:update(dt)
    if self.paused then
        return
    end

    self.paddle:update(dt)
    self.ball:update(dt)

    self.ball:collideWall()
    self.ball:collidePaddle(self.paddle)
end

function PlayScene:render()
    self.paddle:render()
    self.ball:render()

    if self.paused then
        love.graphics.setFont(fonts.large)
        love.graphics.printf('paused', 0, GAME_HEIGHT / 2 - 16, GAME_WIDTH, 'center')
    end
end

return PlayScene
