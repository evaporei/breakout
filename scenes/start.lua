local BaseScene = require('scenes.base')

local fonts = require('fonts')
local sounds = require('sounds')

local StartScene = {}
setmetatable(StartScene, { __index = BaseScene })

local highlighted = 1

function StartScene.new(params)
    local self = {}

    self.stateMachine = params.stateMachine
    self.highScores = params.highScores

    self.time = 0
    self.title = 'breakout'

    setmetatable(self, { __index = StartScene })
    return self
end

function StartScene:update(dt)
    self.time = self.time + dt
end

function StartScene:keypressed(key)
    if key == 'up' or key == 'down' then
        highlighted = highlighted == 1 and 2 or 1
        sounds.paddle_hit:play()
    end
    if key == 'enter' or key == 'return' then
        sounds.confirm:play()
        if highlighted == 1 then
            self.stateMachine:change{'paddle-select',
                highScores = self.highScores,
            }
        elseif highlighted == 2 then
            self.stateMachine:change{'high-scores',
                highScores = self.highScores,
            }
        end
    end
    if key == 'escape' then
        love.event.quit()
    end
end

local function resetColor()
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end

function StartScene:renderTitle()
    local font = fonts.large
    love.graphics.setFont(font)

    local startWidth = (GAME_WIDTH - font:getWidth(self.title)) / 2
    local chHeight = font:getHeight()
    for i = 1, #self.title do
        local color = RAINBOW[i]
        love.graphics.setColor(color.r, color.g, color.b, 255)

        local ch = self.title:sub(i, i)
        local chWidth = font:getWidth(ch)
        startWidth = startWidth + chWidth / 2
        love.graphics.print(ch, startWidth, GAME_HEIGHT / 4 + math.sin(self.time * 5 + 20 * i) * 10, 0, 1, 1, chWidth / 2, chHeight / 2)
        startWidth = startWidth + chWidth / 2
    end

    resetColor()
end

local function highlight(which)
    if highlighted == which then
        love.graphics.setColor(103/255, 255/255, 255/255, 255/255)
    end
end

function StartScene:render()
    self:renderTitle()

    love.graphics.setFont(fonts.medium)
    highlight(1)
    love.graphics.printf('start', 0, GAME_HEIGHT / 2 + 20, GAME_WIDTH, 'center')

    resetColor()

    highlight(2)
    love.graphics.printf('high scores', 0, GAME_HEIGHT / 2 + 40, GAME_WIDTH, 'center')

    resetColor()
end

return StartScene
