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
  if love.keyboard.isDown(up) and self.y > game_screen.pos_y0 then
    self.y = self.y - self.speed
  end
  if love.keyboard.isDown(down) and self.y < game_screen.pos_y1 - 100 then
    self.y = self.y + self.speed
  end
end

local time_last_move = 2.5

local function sleep_move(dt, ball, self)
  local react_time = 3.1
  local move_paddle = false
  time_last_move = time_last_move + dt
  if ball.x >= self.x - ball.size - 20 then
    move_paddle = false
    time_last_move = 0
  elseif time_last_move >= react_time then
    move_paddle = true
  end
  return move_paddle
end

local function predict_ball_pos(ball, self)
  local time_until_intercept = math.abs((ball.x - self.x) / ball.speed_x)
  return ball.y + ball.speed_y * time_until_intercept
end

function Paddle:cpu_predict_move(ball)
  local target_y = predict_ball_pos(ball, self) - 50
  self.y = self.y + (target_y - self.y)
end

function Paddle:cpu_move(ball)
  if ball.y < self.y + 50 and self.y > game_screen.pos_y0 then
    self.y = self.y - self.speed
  elseif ball.y > self.y + 50 and self.y < game_screen.pos_y1 - 100 then
    self.y = self.y + self.speed
  end
end

function Paddle:cpu_move_with_sleep(ball, dt)
  if sleep_move(dt, ball, self) then
    if ball.y < self.y + 50 and self.y > game_screen.pos_y0 then
      self.y = self.y - self.speed
    elseif ball.y > self.y + 50 and self.y < game_screen.pos_y1 - 100 then
      self.y = self.y + self.speed
    end
  end
end

local function intetional_error(ball)
  local error_margin = 25
  local y_error = love.math.random(-error_margin, error_margin)
  return y_error
end

function Paddle:cpu_move_with_sleep_and_error(ball, dt)
  if sleep_move(dt, ball, self) then
    local target_y = ball.y + intetional_error(ball)
    if target_y < self.y + 50 and self.y > game_screen.pos_y0 then
      self.y = self.y - self.speed
    elseif target_y > self.y + 50 and self.y < game_screen.pos_y1 - 100 then
      self.y = self.y + self.speed
    end
  end
end

function Paddle:draw()
  love.graphics.rectangle('fill', self.x, self.y, 20, 100)
end

return Paddle
