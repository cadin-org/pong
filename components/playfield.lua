local game_screen = require 'libcadin.game-screen'
local window = require 'libcadin.window'

local M = {}

local function draw_dotted_line(dot_length, gap_length)
  local num_dots = math.floor(game_screen.height / (dot_length + gap_length))

  for i = 0, num_dots do
    local pos_y = game_screen.pos_y + (i * (dot_length + gap_length))

    love.graphics.rectangle('fill', window.center.x, pos_y, dot_length, dot_length)
  end
end

function M.draw()
  love.graphics.line(game_screen.pos_x, game_screen.pos_y, game_screen.pos_x + game_screen.width, game_screen.pos_y)
  draw_dotted_line(5, 12)
end

return M
