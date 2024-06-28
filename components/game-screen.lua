local game_screen = {}

local function draw_dotted_line(x1, y1, x2, y2, dot_length, gap_length)
  local num_dots = math.floor(love.graphics.getHeight() / (dot_length + gap_length))

  local dx = (x2 - x1) / love.graphics.getHeight()
  local dy = (y2 - y1) / love.graphics.getHeight()

  for i = 0, num_dots do
    local start_x = x1 + (i * (dot_length + gap_length)) * dx
    local start_y = y1 + (i * (dot_length + gap_length)) * dy

    love.graphics.rectangle('fill', start_x, start_y, dot_length, dot_length)
  end
end

function game_screen.draw()
  love.graphics.line(0, 40, love.graphics.getWidth(), 40)
  draw_dotted_line(love.graphics.getWidth() / 2, 40, love.graphics.getWidth() / 2, love.graphics.getHeight(), 5, 12)
end

return game_screen
