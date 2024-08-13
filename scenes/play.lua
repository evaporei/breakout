local BaseScene = require('scenes.base')

local sounds = require('sounds')
local fonts = require('fonts')
local render = require('render')

local Ball = require('ball')

local PlayScene = {}
setmetatable(PlayScene, { __index = BaseScene })

function PlayScene.new(params)
    local self = {}

    self.stateMachine = params.stateMachine
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score

    self.ball = Ball.new(self.paddle)
    self.paused = false

    setmetatable(self, { __index = PlayScene })
    return self
end

function PlayScene:keypressed(key)
    if key == 'space' then
        self.paused = not self.paused
        sounds.pause:play()
    elseif key == 'escape' then
        love.event.quit()
    end
end

function PlayScene:update(dt)
    if self.paused then
        return
    end

    if self.ball:offScreen() then
        self.health = self.health - 1
        sounds.hurt:play()

        if self.health == 0 then
            self.stateMachine:change{'game-over',
                score = self.score,
            }
        else
            self.stateMachine:change{'serve',
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
            }
        end
    end

    self.paddle:update(dt)
    self.ball:update(dt)

    self.ball:bounceWall()

    if self.ball:collidesWith(self.paddle) then
        self.ball.vy = -self.ball.vy
        self.ball.y = self.paddle.y - 8

        -- ball hit paddle on its left side while moving left
        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.vx < 0 then
            self.ball.vx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
        -- ball hit paddle on its right side while moving right
        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.vx > 0 then
            self.ball.vx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end

        sounds.paddle_hit:play()
    end

    for _, brick in pairs(self.bricks) do
        if not brick.deleted and self.ball:collidesWith(brick) then
            brick:hit()

            self.score = self.score + (brick.tier * 200 + brick.color * 25)

            -- left edge; only check if we're moving right
            if self.ball.x + self.ball.width / 4 < brick.x and self.ball.vx > 0 then
                self.ball.vx = -self.ball.vx
                self.ball.x = brick.x - brick.width / 2
            elseif self.ball.x + self.ball.width / 4 * 3 > brick.x + brick.width and self.ball.vx < 0 then
                self.ball.vx = -self.ball.vx
                self.ball.x = brick.x + brick.width
            elseif self.ball.y < self.ball.y then
                self.ball.vy = -self.ball.vy
                self.ball.y = brick.y + brick.height / 2
            else
                self.ball.vy = -self.ball.vy
                self.ball.y = brick.y + brick.height
            end

            self.ball.vy = self.ball.vy * 1.02

            break
        end
    end

    for _, brick in pairs(self.bricks) do
        brick:update(dt)
    end
end

function PlayScene:render()
    self.paddle:render()
    self.ball:render()
    for _, brick in pairs(self.bricks) do
        brick:render()
        brick:renderParticles()
    end

    render.score(self.score)
    render.health(self.health)

    if self.paused then
        love.graphics.setFont(fonts.large)
        love.graphics.printf('paused', 0, GAME_HEIGHT / 2 - 16, GAME_WIDTH, 'center')
    end
end

return PlayScene
