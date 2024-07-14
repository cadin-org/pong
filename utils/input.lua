local menu = require 'components.menu'
local menu_pause = require 'components.menu-pause'

local input = {}

function input.keypressed(key)
  menu_pause.keypressed(key)
  menu.keypressed(key)
  if key == 'p' and menu.game_states.playing then
    menu.change_state 'pause'
  end
end

return input
