local ball = {}

ball.properties = {
  x = love.graphics.getWidth() / 2,
  y = love.graphics.getHeight() / 2,
  size = 10,
  speed_x = 300,
  speed_y = 300,
}

function ball.move(dt)
  ball.properties.x = ball.properties.x + ball.properties.speed_x * dt
  ball.properties.y = ball.properties.y + ball.properties.speed_y * dt

  if ball.properties.x <= 0 or ball.properties.x >= love.graphics.getWidth() - ball.properties.size then
    ball.properties.speed_x = -ball.properties.speed_x
  end
  if ball.properties.y <= 40 or ball.properties.y >= love.graphics.getHeight() - ball.properties.size then
    ball.properties.speed_y = -ball.properties.speed_y
  end
end

function ball.draw()
  love.graphics.circle('fill', ball.properties.x, ball.properties.y, ball.properties.size)
end

return ball
