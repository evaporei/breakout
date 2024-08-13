local BaseScene = require('scenes.base')

local sounds = require('sounds')
local fonts = require('fonts')

local HighScoresScene = {}
setmetatable(HighScoresScene, { __index = BaseScene })

function HighScoresScene.new(params)
    local self = {}

    self.stateMachine = params.stateMachine
    self.highScores = params.highScores

    setmetatable(self, { __index = HighScoresScene })
    return self
end

function HighScoresScene:keypressed(key)
    if key == 'escape' then
        sounds['wall_hit']:play()

        self.stateMachine:change{'start',
            highScores = self.highScores,
        }
    end
end

function HighScoresScene:render()
    love.graphics.setFont(fonts.large)
    love.graphics.printf('high scores', 0, 20, GAME_WIDTH, 'center')

    love.graphics.setFont(fonts.medium)
    for i = 1, 10 do
        local name = self.highScores[i].name or '---'
        local score = self.highScores[i].score or '---'

        love.graphics.printf(tostring(i) .. '.', GAME_WIDTH / 4, 60 + i * 13, 50, 'left')
        love.graphics.printf(name, GAME_WIDTH / 4 + 38, 60 + i * 13, 50, 'right')
        love.graphics.printf(tostring(score), GAME_WIDTH / 2, 60 + i * 13, 100, 'right')
    end

    love.graphics.setFont(fonts.small)
    love.graphics.printf("press 'Esc' to return to the main menu", 0, GAME_HEIGHT - 18, GAME_WIDTH, 'center')
end

return HighScoresScene
