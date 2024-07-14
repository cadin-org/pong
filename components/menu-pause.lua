local Menu_option = require 'components.menu-option'
local menu = require 'components.menu'

local menu_pause = {}

local menu_font_path = 'assets/fonts/PressStart2P-Regular.ttf'
local menu_font = love.graphics.newFont(menu_font_path, 24)
local menu_pause_options = {
  Menu_option:new('Resume', menu_font, menu.change_state, 'playing', true),
  Menu_option:new('Main Menu', menu_font, menu.change_state, 'standard', false),
  Menu_option:new('Exit', menu_font, love.event.quit, nil, false),
}

function menu_pause.draw()
  menu_pause_options[1]:draw(-2)
  menu_pause_options[2]:draw(0)
  menu_pause_options[3]:draw(2)
end

function menu_pause.keypressed(key)
  if menu.game_states.pause then
    if key == 'return' then
      for idx = 1, #menu_pause_options, 1 do
        if menu_pause_options[idx].is_hl then
          menu_pause_options[idx]:select_option()
          break
        end
      end
    elseif IS_DOWN_KEY(key) then
      for idx = 1, #menu_pause_options - 1, 1 do
        if menu_pause_options[idx].is_hl then
          menu_pause_options[idx]:shift_hl()
          menu_pause_options[idx + 1]:shift_hl()
          break
        end
      end
    elseif IS_UP_KEY(key) then
      for idx = 2, #menu_pause_options, 1 do
        if menu_pause_options[idx].is_hl then
          menu_pause_options[idx]:shift_hl()
          menu_pause_options[idx - 1]:shift_hl()
          break
        end
      end
    end
  end
end

return menu_pause
