local function paddle_cpu(paddle2, ball)
  if ball.y < paddle2.y + 50 and paddle2.y > 40 then
    paddle2.y = paddle2.y - paddle2.speed
  elseif ball.y > paddle2.y + 50 and paddle2.y < love.graphics.getHeight() - 100 then
    paddle2.y = paddle2.y + paddle2.speed
  end
end

return paddle_cpu
