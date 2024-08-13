local sounds = require('sounds')
local images = require('images')
local sprites = require('sprites')

local Brick = {}

local paletteColors = {
    -- blue
    [1] = { r = 99, g = 155, b = 255 },
    -- green
    [2] = { r = 106, g = 190, b = 47 },
    -- red
    [3] = { r = 217, g = 87, b = 99 },
    -- purple
    [4] = { r = 215, g = 123, b = 186 },
    -- gold
    [5] = { r = 251, g = 242, b = 54 },
}

function Brick.new(x, y)
    local self = {}

    self.x, self.y = x, y
    self.width, self.height = 32, 16

    self.tier = 0
    self.color = 1

    self.deleted = false

    self.psystem = love.graphics.newParticleSystem(images.particle, 64)

    self.psystem:setParticleLifetime(0.5, 1)
    self.psystem:setLinearAcceleration(-15, 0, 15, 80)
    self.psystem:setEmissionArea('normal', 10, 10)

    setmetatable(self, { __index = Brick })
    return self
end

function Brick:update(dt)
    self.psystem:update(dt)
end

function Brick:hit()
    self.psystem:setColors(
        paletteColors[self.color].r / 255,
        paletteColors[self.color].g / 255,
        paletteColors[self.color].b / 255,
        55 * (self.tier + 1) / 255,
        paletteColors[self.color].r / 255,
        paletteColors[self.color].g / 255,
        paletteColors[self.color].b / 255,
        0
    )
    self.psystem:emit(64)

    sounds['brick-hit-2']:stop()
    sounds['brick-hit-2']:play()

    if self.tier > 0 then
        if self.color == 1 then
            self.tier = self.tier - 1
            self.color = 5
        else
            self.color = self.color - 1
        end
    else
        if self.color == 1 then
            self.deleted = true
        else
            self.color = self.color - 1
        end
    end

    if self.deleted then
        sounds['brick-hit-1']:stop()
        sounds['brick-hit-1']:play()
    end
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

function Brick:renderParticles()
    love.graphics.draw(self.psystem, self.x + self.width / 2, self.y + self.height / 2)
end

return Brick
