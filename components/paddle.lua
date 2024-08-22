local game_screen = require 'libcadin.game-screen'
local window = require 'libcadin.window'

local Paddle = {}
Paddle.__index = Paddle

function Paddle:new(x, y)
  local instance = setmetatable({}, Paddle)
  instance.x = x
  instance.y = y
  instance.speed = 5
  instance.last_sleep = 0
  instance.sleeping = false
  instance.score = 0
  return instance
end

function Paddle:player_move(up, down)
  if love.keyboard.isDown(up) and self.y - 5 > game_screen.pos_y0 then
    self.y = self.y - self.speed
  end
  if love.keyboard.isDown(down) and self.y + 5 < game_screen.pos_y1 - 100 then
    self.y = self.y + self.speed
  end
end

function Paddle:cpu_move(ball)
  local time = love.timer.getTime()

  local dist_factor = math.ceil(ball.x)
  local direction_factor = 5
  if ball.speed_x > 0 then
    direction_factor = 1
  end

  local glitched = love.math.random(0, math.ceil(dist_factor / direction_factor)) == 0

  if glitched then
    self.last_sleep = time
    self.sleeping = true
  elseif self.last_sleep + 0.2 < time then
    self.sleeping = false
  end

  if not self.sleeping then
    if ball.y < self.y + 50 and self.y - 5 > game_screen.pos_y0 then
      self.y = self.y - self.speed
    elseif ball.y > self.y + 50 and self.y + 5 < game_screen.pos_y1 - 100 then
      self.y = self.y + self.speed
    end
  end
end

function Paddle:draw()
  love.graphics.rectangle('fill', self.x, self.y, 20, 100)
end

return Paddle
