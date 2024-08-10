local game_screen = require 'libcadin.game-screen'

local Paddle = {}
Paddle.__index = Paddle

function Paddle:new(x, y)
  local instance = setmetatable({}, Paddle)
  instance.x = x
  instance.y = y
  instance.speed = 5
  instance.score = 0
  return instance
end

function Paddle:player_move(up, down)
  if love.keyboard.isDown(up) and self.y > game_screen.pos_y then
    self.y = self.y - self.speed
  end
  if love.keyboard.isDown(down) and self.y < game_screen.pos_y + game_screen.height - 100 then
    self.y = self.y + self.speed
  end
end

function Paddle:cpu_move(ball)
  if ball.y < self.y + 50 and self.y > game_screen.pos_y then
    self.y = self.y - self.speed
  elseif ball.y > self.y + 50 and self.y < game_screen.pos_y + game_screen.height - 100 then
    self.y = self.y + self.speed
  end
end

function Paddle:draw()
  love.graphics.rectangle('fill', self.x, self.y, 20, 100)
end

return Paddle
