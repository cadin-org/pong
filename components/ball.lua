local ball = {}

local ball_hit_paddle_sound = love.audio.newSource('assets/sounds/ball-hitting-paddle.mp3', 'static')
ball.x = love.graphics.getWidth() / 2
ball.y = love.graphics.getHeight() / 2
ball.size = 10
ball.speed_x = 300
ball.speed_y = 300

local function paddles_collision(paddle1, paddle2)
  if ball.x < paddle1.x + 20 + ball.size and ball.y + ball.size >= paddle1.y and ball.y <= paddle1.y + 100 then
    ball.x = paddle1.x + 20 + ball.size
    ball.speed_x = -ball.speed_x
    ball_hit_paddle_sound:play()
  end

  if ball.x > paddle2.x - ball.size and ball.y + ball.size >= paddle2.y and ball.y <= paddle2.y + 100 then
    ball.x = paddle2.x - ball.size
    ball.speed_x = -ball.speed_x
    ball_hit_paddle_sound:play()
  end
end

local function wall_collision(paddle1, paddle2)
  if ball.x < ball.size then
    ball.x = love.graphics.getWidth() / 2
    ball.y = love.graphics.getHeight() / 2
    ball.speed_x = -ball.speed_x
    paddle2.score = paddle2.score + 1
  elseif ball.x + ball.size > love.graphics.getWidth() then
    ball.x = love.graphics.getWidth() / 2
    ball.y = love.graphics.getHeight() / 2
    ball.speed_x = -ball.speed_x
    paddle1.score = paddle1.score + 1
  end

  if ball.y < 40 + ball.size then
    ball.y = 40 + ball.size
    ball.speed_y = -ball.speed_y
  elseif ball.y + ball.size > love.graphics.getHeight() then
    ball.y = love.graphics.getHeight() - ball.size
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
