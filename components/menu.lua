local MenuOption = require 'components.menu-option'

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

local menu_font_path = 'assets/fonts/PressStart2P-Regular.ttf'
local menu_font = love.graphics.newFont(menu_font_path, 24)

local menu_options = {
  MenuOption:new('1 Player', menu_font, menu.change_state, 'standard', true),
  MenuOption:new('2 Players', menu_font, menu.change_state, 'playing', false),
  MenuOption:new('Exit', menu_font, love.event.quit, nil, false),
}

function menu.keypressed(key)
  if key == 'return' then
    for idx = 1, #menu_options, 1 do
      if menu_options[idx].is_hl then
        menu_options[idx]:select_option()
        break
      end
    end
  elseif IS_DOWN_KEY(key) then
    for idx = 1, #menu_options - 1, 1 do
      if menu_options[idx].is_hl then
        menu_options[idx]:shift_hl()
        menu_options[idx + 1]:shift_hl()
        break
      end
    end
  elseif IS_UP_KEY(key) then
    for idx = 2, #menu_options, 1 do
      if menu_options[idx].is_hl then
        menu_options[idx]:shift_hl()
        menu_options[idx - 1]:shift_hl()
        break
      end
    end
  end
end

function menu.draw()
  menu_options[1]:draw(-2)
  menu_options[2]:draw(0)
  menu_options[3]:draw(2)
end

return menu
