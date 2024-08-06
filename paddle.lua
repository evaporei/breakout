local images = require('images')
local sprites = require('sprites')

local Paddle = {}

local SPEED = 200

function Paddle.new()
    local self = {}

    self.x = GAME_WIDTH / 2 - 32
    self.y = GAME_HEIGHT - 32

    self.vx = 0

    self.width = 64
    self.height = 16

    -- blue = 1, green = 2, red = 3, purple = 4
    self.skin = 1
    -- small = 1, mid = 2, large = 3, huge = 4
    self.size = 2

    setmetatable(self, { __index = Paddle })
    return self
end

function Paddle:handleInput()
    if love.keyboard.isDown('left') then
        self.vx = -SPEED
    elseif love.keyboard.isDown('right') then
        self.vx = SPEED
    else
        self.vx = 0
    end
end

function Paddle:update(dt)
    self:handleInput()

    if self.vx < 0 then
        self.x = math.max(0, self.x + self.vx * dt)
    else
        self.x = math.min(GAME_WIDTH - self.width, self.x + self.vx * dt)
    end
end

function Paddle:render()
    love.graphics.draw(
        images.breakout,
        sprites.paddles[self.size + 4 * (self.skin - 1)],
        self.x,
        self.y
    )
end

return Paddle
