local BaseScene = require('scenes.base')

local Paddle = require('paddle')
local sounds = require('sounds')
local fonts = require('fonts')

local PlayScene = {}
setmetatable(PlayScene, { __index = BaseScene })

function PlayScene.new(stateMachine)
    local self = {}

    self.stateMachine = stateMachine

    self.paddle = Paddle.new()
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
end

function PlayScene:render()
    self.paddle:render()

    if self.paused then
        love.graphics.setFont(fonts.large)
        love.graphics.printf('paused', 0, GAME_HEIGHT / 2 - 16, GAME_WIDTH, 'center')
    end
end

return PlayScene
