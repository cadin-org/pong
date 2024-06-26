local Button = require 'componets.button'
local menu = {}

menu.game_states = {
  standard = true,
  pause = false,
  playing = false,
  gameover = false,
}

function menu.change_state(state)
  menu.game_states.standard = state == 'standard'
  menu.game_states.pause = state == 'pause'
  menu.game_states.playing = state == 'playing'
  menu.game_states.gameover = state == 'gameover'
end

local buttons = {}

function menu.load()
  buttons.play = Button('Play', menu.change_state, 'playing', 200, 80)
  buttons.exit = Button('Exit', love.event.quit, nil, 200, 80)
end

function love.mousepressed(x, y, button)
  if button == 1 then
    buttons.play:check_click(x, y)
    buttons.exit:check_click(x, y)
  end
end

function menu.draw()
  if menu.game_states.standard then
    buttons.play:draw(10, 20, 25, 10)
    buttons.exit:draw(10, 110, 25, 10)
  end
end

return menu
