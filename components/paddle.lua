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

function Paddle:move(up, down)
  if love.keyboard.isDown(up) and self.y > 40 then
    self.y = self.y - self.speed
  end
  if love.keyboard.isDown(down) and self.y < love.graphics.getHeight() - 100 then
    self.y = self.y + self.speed
  end
end

function Paddle:draw()
  love.graphics.rectangle('fill', self.x, self.y, 20, 100)
end

return Paddle
