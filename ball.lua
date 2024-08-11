local images = require('images')
local sprites = require('sprites')
local sounds = require('sounds')

local Ball = {}

function Ball.new(paddle, skin)
    local self = {}

    self.width = 8
    self.height = 8

    self.x = paddle.x + paddle.width / 2 - self.width / 2
    self.y = paddle.y - paddle.height

    self.vx = math.random(-200, 200)
    self.vy = math.random(-50, -60)

    self.skin = skin or math.random(7)

    setmetatable(self, { __index = Ball })
    return self
end

function Ball:bounceWall()
    if self.x > GAME_WIDTH - self.width then
        self.x = GAME_WIDTH - self.width
        self.vx = -self.vx
        sounds.wall_hit:play()
    end

    if self.x < 0 then
        self.x = 0
        self.vx = -self.vx
        sounds.wall_hit:play()
    end

    if self.y < 0 then
        self.y = 0
        self.vy = -self.vy
        sounds.wall_hit:play()
    end
end

-- obj = paddle or brick
function Ball:collidesWith(obj)
    if self.x + self.width < obj.x or self.x > obj.x + obj.width then
        return false
    end
    if self.y + self.height < obj.y or self.y > obj.y + obj.height then
        return false
    end
    return true
end

function Ball:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

function Ball:render()
    love.graphics.draw(
        images.breakout,
        sprites.balls[self.skin],
        self.x,
        self.y
    )
end

return Ball
