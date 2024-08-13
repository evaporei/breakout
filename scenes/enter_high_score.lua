local BaseScene = require('scenes.base')

local sounds = require('sounds')
local fonts = require('fonts')
local fs = require('fs')

local EnterHighScoreScene = {}
setmetatable(EnterHighScoreScene, { __index = BaseScene })

local chars = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
}

local highlightedChar = 1

function EnterHighScoreScene.new(params)
    local self = {}

    self.stateMachine = params.stateMachine
    self.score = params.score
    self.highScores = params.highScores
    self.scoreIndex = params.scoreIndex

    setmetatable(self, { __index = EnterHighScoreScene })
    return self
end

function EnterHighScoreScene:keypressed(key)
    if key == 'enter' or key == 'return' then
        local name = string.char(chars[1] + 65) .. string.char(chars[2] + 65) .. string.char(chars[3] + 65)

        table.insert(self.highScores, self.scoreIndex, { score = self.score, name = name })

        fs.saveHighScores(self.highScores)

        self.stateMachine:change{'high-scores',
            highScores = self.highScores,
        }
    end

    if key == 'left' then
        highlightedChar = highlightedChar - 1
        highlightedChar = ((highlightedChar - 1) % 3) + 1
        sounds.select:play()
    elseif key == 'right' then
        highlightedChar = highlightedChar + 1
        highlightedChar = ((highlightedChar - 1) % 3) + 1
        sounds.select:play()
    elseif key == 'up' then
        chars[highlightedChar] = chars[highlightedChar] - 1
        chars[highlightedChar] = chars[highlightedChar] % 26
    elseif key == 'down' then
        chars[highlightedChar] = chars[highlightedChar] + 1
        chars[highlightedChar] = chars[highlightedChar] % 26
    end
end

function EnterHighScoreScene:render()
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(fonts.medium)
    love.graphics.printf('your score: ' .. tostring(self.score), 0, 30, GAME_WIDTH, 'center')

    love.graphics.setFont(fonts.large)
    if highlightedChar == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[1] + 65), GAME_WIDTH / 2 - 28, GAME_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedChar == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[2] + 65), GAME_WIDTH / 2 - 6, GAME_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedChar == 3 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[3] + 65), GAME_WIDTH / 2 + 20, GAME_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(fonts.small)
    love.graphics.printf("press 'Enter' to confirm", 0, GAME_HEIGHT - 18, GAME_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
end

return EnterHighScoreScene
