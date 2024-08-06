local sounds = require('sounds')
local images = require('images')
local sprites = require('sprites')

local Brick = {}

function Brick.new(x, y)
    local self = {}

    self.x, self.y = x, y
    self.width, self.height = 32, 16

    self.tier = 0
    self.color = 1

    self.deleted = false

    setmetatable(self, { __index = Brick })
    return self
end

function Brick:hit()
    sounds['brick-hit-2']:play()
    self.deleted = true
end

function Brick:render()
    if self.deleted then
        return
    end

    love.graphics.draw(
        images.breakout,
        sprites.bricks[1 + (self.color - 1) * 4],
        self.x,
        self.y
    )
end

return Brick
