local menu = require 'components.menu'
local menu_pause = require 'components.menu-pause'

local input = {}

function input.keypressed(key)
  if menu.game_states.pause then
    menu_pause.keypressed(key)
  elseif menu.game_states.standard then
    menu.keypressed(key)
  end
  if key == 'p' and (menu.game_states.playing or menu.game_states.playing_single) then
    menu.change_state 'pause'
  end
end

return input
