local MenuOption = require 'components.menu-option'

local menu = {}

local menu_font_path = 'assets/fonts/PressStart2P-Regular.ttf'
local menu_font = love.graphics.newFont(menu_font_path, 24)

function menu.load_main_options()
  return {
    MenuOption:new('1 Player', menu_font, 'change_mode', 'single_player', true),
    MenuOption:new('2 Players', menu_font, 'change_mode', 'multiplayer', false),
    MenuOption:new('Quit', menu_font, 'quit', nil, false),
  }
end

function menu.load_pause_options()
  return {
    MenuOption:new('Resume', menu_font, 'change_state', 'playing', true),
    MenuOption:new('Restart', menu_font, 'new_game', nil, false),
    MenuOption:new('Main Menu', menu_font, 'change_state', 'title_screen', false),
    MenuOption:new('Quit', menu_font, 'quit', nil, false),
  }
end

function menu.handle_input(menu_options, key)
  if key == 'return' then
    for idx = 1, #menu_options, 1 do
      if menu_options[idx].is_hl then
        menu_options[idx]:select_option()
        if idx ~= 1 then
          menu_options[1]:shift_hl()
          menu_options[idx]:shift_hl()
        end
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

function menu.draw(menu_options)
  local pos_factor = 1 - #menu_options

  for idx = 1, #menu_options, 1 do
    menu_options[idx]:draw(pos_factor)
    pos_factor = pos_factor + 2
  end
end

return menu
