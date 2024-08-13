local BaseScene = require('scenes.base')

local sounds = require('sounds')
local fonts = require('fonts')

local GameOverScene = {}
setmetatable(GameOverScene, { __index = BaseScene })

function GameOverScene.new(params)
    local self = {}

    self.stateMachine = params.stateMachine
    self.score = params.score
    self.highScores = params.highScores

    setmetatable(self, { __index = GameOverScene })
    return self
end

function GameOverScene:keypressed(key)
    if key == 'enter' or key == 'return' then
        local highScore = false

        local scoreIndex = 11

        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
            if self.score > score then
                scoreIndex = i
                highScore = true
            end
        end

        if highScore then
            sounds['high_score']:play()
            self.stateMachine:change{'enter-high-score',
                score = self.score,
                highScores = self.highScores,
                scoreIndex = scoreIndex,
            }
        else
            self.stateMachine:change{'start',
                highScores = self.highScores
            }
        end

    end

    if key == 'escape' then
        love.event.quit()
    end
end

function GameOverScene:render()
    love.graphics.setFont(fonts.large)
    love.graphics.printf('GAME OVER', 0, GAME_HEIGHT / 3, GAME_WIDTH, 'center')

    love.graphics.setFont(fonts.medium)
    love.graphics.printf('final score: ' .. tostring(self.score), 0, GAME_HEIGHT / 2, GAME_WIDTH, 'center')
    love.graphics.printf("press 'Enter'!", 0, GAME_HEIGHT / 4 * 3, GAME_WIDTH, 'center')
end

return GameOverScene
