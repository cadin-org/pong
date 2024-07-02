local scoreboard = {}

function scoreboard.draw(paddle1, paddle2)
  love.graphics.printf(paddle1.score .. '   ' .. paddle2.score, 0, 40, love.graphics.getWidth(), 'center')
end

return scoreboard
