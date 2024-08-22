local catppuccin = require 'libcadin.catppuccin'
local game_screen = require 'libcadin.game-screen'
local window = require 'libcadin.window'

local M = {}

local function draw_dotted_line(dot_length, gap_length)
  local num_dots = math.floor(game_screen.height / (dot_length + gap_length)) - 1

  for i = 0, num_dots do
    local pos_y = game_screen.pos_y0 + (num_dots / 4) + (i * (dot_length + gap_length))

    love.graphics.rectangle('fill', window.center.x, pos_y, dot_length, dot_length)
  end
end

function M.draw(paddle1, paddle2)
  love.graphics.setColor(catppuccin.OVERLAY0)
  draw_dotted_line(4, 16)

  love.graphics.printf(paddle1.score .. '   ' .. paddle2.score, 0, game_screen.pos_y0 + 20, window.width, 'center')

  love.graphics.setColor(catppuccin.TEXT)
  love.graphics.line(game_screen.pos_x0, game_screen.pos_y0, game_screen.pos_x1, game_screen.pos_y0)
  love.graphics.line(game_screen.pos_x0, game_screen.pos_y1, game_screen.pos_x1, game_screen.pos_y1)
end

return M
