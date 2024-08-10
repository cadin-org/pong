local game_screen = require 'libcadin.game-screen'
local window = require 'libcadin.window'

local ball = {}

ball.x = window.center.x
ball.y = window.center.y
ball.size = 10
ball.speed_x = 300
ball.speed_y = 300

local function paddles_collision(paddle1, paddle2)
  if ball.x < paddle1.x + 20 + ball.size and ball.y + ball.size >= paddle1.y and ball.y <= paddle1.y + 100 then
    ball.x = paddle1.x + 20 + ball.size
    ball.speed_x = -ball.speed_x
  end

  if ball.x > paddle2.x - ball.size and ball.y + ball.size >= paddle2.y and ball.y <= paddle2.y + 100 then
    ball.x = paddle2.x - ball.size
    ball.speed_x = -ball.speed_x
  end
end

local function wall_collision(paddle1, paddle2)
  if ball.x < ball.size + game_screen.pos_x then
    ball.x = window.center.x
    ball.y = window.center.y
    ball.speed_x = -ball.speed_x
    paddle2.score = paddle2.score + 1
  elseif ball.x > game_screen.pos_x + game_screen.width - ball.size then
    ball.x = window.center.x
    ball.y = window.center.y
    ball.speed_x = -ball.speed_x
    paddle1.score = paddle1.score + 1
  end

  if ball.y < game_screen.pos_y + ball.size then
    ball.y = game_screen.pos_y + ball.size
    ball.speed_y = -ball.speed_y
  elseif ball.y > game_screen.pos_y + game_screen.height - ball.size then
    ball.y = game_screen.pos_y + game_screen.height - ball.size
    ball.speed_y = -ball.speed_y
  end
end

function ball.move(paddle1, paddle2, dt)
  ball.x = ball.x + ball.speed_x * dt
  ball.y = ball.y + ball.speed_y * dt

  wall_collision(paddle1, paddle2)
  paddles_collision(paddle1, paddle2)
end

function ball.draw()
  love.graphics.circle('fill', ball.x, ball.y, ball.size)
end

return ball
