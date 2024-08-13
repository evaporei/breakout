local BaseScene = require('scenes.base')

local fonts = require('fonts')
local render = require('render')
local LevelMaker = require('level_maker')

local VictoryScene = {}
setmetatable(VictoryScene, { __index = BaseScene })

function VictoryScene.new(params)
    local self = {}

    self.stateMachine = params.stateMachine
    self.level = params.level
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.ball = params.ball

    setmetatable(self, { __index = VictoryScene })
    return self
end

function VictoryScene:keypressed(key)
    if key == 'enter' or key == 'return' then
        self.stateMachine:change{'serve',
            level = self.level + 1,
            paddle = self.paddle,
            bricks = LevelMaker.createMap(self.level + 1),
            health = self.health,
            score = self.score,
            ball = self.ball,
        }
    end
end

function VictoryScene:update(dt)
    self.paddle:update(dt)
    self.ball:follow(self.paddle)
end

function VictoryScene:render()
    self.paddle:render()
    self.ball:render()

    render.score(self.score)
    render.health(self.health)

    love.graphics.setFont(fonts.large)
    love.graphics.printf("stage " .. tostring(self.level) .. " clear", 0, GAME_HEIGHT / 4, GAME_WIDTH, 'center')

    love.graphics.setFont(fonts.medium)
    love.graphics.printf("press 'Enter' to serve!", 0, GAME_HEIGHT / 2, GAME_WIDTH, 'center')
end

return VictoryScene
