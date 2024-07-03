local MenuOption = require 'components.menu-option'
local menu = {}

menu.game_states = {
  standard = true,
  pause = false,
  playing = false,
  gameover = false,
}

local x_center = love.graphics.getWidth() / 2
local y_center = love.graphics.getHeight() / 2

function menu.change_state(state)
  menu.game_states.standard = state == 'standard'
  menu.game_states.pause = state == 'pause'
  menu.game_states.playing = state == 'playing'
  menu.game_states.gameover = state == 'gameover'
end

local menu_options = {}

function menu.load()
  local menu_font_path = 'assets/fonts/PressStart2P-Regular.ttf'
  local menu_font = love.graphics.newFont(menu_font_path, 32)

  menu_options.play = MenuOption('Play', menu_font, true, menu.change_state, 'playing', 200, 40)
  menu_options.exit = MenuOption('Exit', menu_font, false, love.event.quit, nil, 200, 40)
end

function love.keypressed(key)
  if key == 'return' then
    menu_options.play:select_option_if_highlighted()
    menu_options.exit:select_option_if_highlighted()
  elseif IS_DOWN_KEY(key) and menu_options.play.is_highlighted then
    menu_options.play:shift_highlight()
    menu_options.exit:shift_highlight()
  elseif IS_UP_KEY(key) and menu_options.exit.is_highlighted then
    menu_options.play:shift_highlight()
    menu_options.exit:shift_highlight()
  end
end

function menu.draw()
  menu_options.play:draw(x_center - 50, y_center - 40)
  menu_options.exit:draw(x_center - 50, y_center + 40)
end

return menu
