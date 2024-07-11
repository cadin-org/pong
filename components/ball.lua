local ball = {}
ball.__index = ball

function ball:new()
  local instance = setmetatable({}, ball)
  instance.x = love.graphics.getWidth() / 2
  instance.y = love.graphics.getHeight() / 2
  instance.size = 10
  instance.speed_x = 300
  instance.speed_y = 300
  return instance
end

function ball:paddles_collision(paddle1, paddle2)
  if self.x < paddle1.x + 20 + self.size and self.y + self.size >= paddle1.y and self.y <= paddle1.y + 100 then
    self.x = paddle1.x + 20 + self.size
    self.speed_x = -self.speed_x
  end

  if self.x > paddle2.x - self.size and self.y + self.size >= paddle2.y and self.y <= paddle2.y + 100 then
    self.x = paddle2.x - self.size
    self.speed_x = -self.speed_x
  end
end

function ball:wall_collision(paddle1, paddle2)
  if self.x < self.size then
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.speed_x = -self.speed_x
    paddle2.score = paddle2.score + 1
  elseif self.x + self.size > love.graphics.getWidth() then
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.speed_x = -self.speed_x
    paddle1.score = paddle1.score + 1
  end

  if self.y < 40 + self.size then
    self.y = 40 + self.size
    self.speed_y = -self.speed_y
  elseif self.y + self.size > love.graphics.getHeight() then
    self.y = love.graphics.getHeight() - self.size
    self.speed_y = -self.speed_y
  end
end

function ball:move(paddle1, paddle2, dt)
  self.x = self.x + self.speed_x * dt
  self.y = self.y + self.speed_y * dt

  self:wall_collision(paddle1, paddle2)
  self:paddles_collision(paddle1, paddle2)
end

function ball:draw()
  love.graphics.circle('fill', self.x, self.y, self.size)
end

return ball
