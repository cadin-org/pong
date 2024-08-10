local window = require 'libcadin.window'

local scoreboard = {}

function scoreboard.draw(paddle1, paddle2)
  love.graphics.printf(paddle1.score .. '   ' .. paddle2.score, 0, 150, window.width, 'center')
end

return scoreboard
