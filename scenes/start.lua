local BaseScene = require('scenes.base')

local fonts = require('fonts')

local StartScene = {}
setmetatable(StartScene, { __index = BaseScene })

function StartScene.new(stateMachine)
    local self = {}

    self.stateMachine = stateMachine

    self.time = 0
    self.title = 'breakout'

    setmetatable(self, { __index = StartScene })
    return self
end

function StartScene:update(dt)
    self.time = self.time + dt
end

function StartScene:keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
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
end

function StartScene:render()
    self:renderTitle()
end

return StartScene
