local catppuccin = require 'libcadin.catppuccin'
local fonts = require 'libcadin.fonts'
local game_screen = require 'libcadin.game-screen'
local menu = require 'libcadin.menu'
local splash = require 'libcadin.splash-screen'
local window = require 'libcadin.window'
local Paddle = require 'components.paddle'
local playfield = require 'components.playfield'
local ball = require 'components.ball'

-- single_player, multiplayer
GAME_MODE = 'single_player'

-- title_screen, pause_screen, playing, gameover
GAME_STATE = 'title_screen'

local paddles = {
  Paddle:new(game_screen.pos_x0, window.center.y - 50),
  Paddle:new(game_screen.pos_x1 - 20, window.center.y - 50),
}

function NEW_GAME()
  paddles[1].score = 0
  paddles[2].score = 0
  paddles[1].y = window.center.y - 50
  paddles[2].y = window.center.y - 50
  ball.x = window.center.x
  ball.y = window.center.y

  GAME_STATE = 'playing'
end

function love.load()
  love.graphics.setBackgroundColor(catppuccin.MANTLE)

  MAIN_MENU = menu.multi_player_options()
  PAUSE_MENU = menu.pause_options()

  love.graphics.setFont(fonts.ps2p_large)

  splash.load()
end

function love.update(dt)
  if GAME_STATE == 'playing' then
    if GAME_MODE == 'single_player' then
      paddles[1]:player_move('w', 's')
      paddles[2]:cpu_move(ball)
    elseif GAME_MODE == 'multiplayer' then
      paddles[1]:player_move('w', 's')
      paddles[2]:player_move('up', 'down')
    end
    ball.move(paddles[1], paddles[2], dt)
  end
end

function love.draw()
  local time = love.timer.getTime()

  -- splash.start(time)

  if time >= 0 then
    if GAME_STATE == 'title_screen' then
      menu.draw(MAIN_MENU)
    elseif GAME_STATE == 'pause_screen' then
      menu.draw(PAUSE_MENU)
    elseif GAME_STATE == 'playing' then
      game_screen.frame()
      love.graphics.printf('press P to pause the game', fonts.ps2p_small, 0, game_screen.pos_y1 + 20, window.width, 'center')
      playfield.draw(paddles[1], paddles[2])
      ball.draw()
      paddles[1]:draw()
      paddles[2]:draw()
    end
  end
end

function love.keypressed(key)
  if key == 'p' and GAME_STATE == 'playing' then
    GAME_STATE = 'pause_screen'
  elseif GAME_STATE == 'title_screen' then
    menu.handle_input(MAIN_MENU, key)
  elseif GAME_STATE == 'pause_screen' then
    menu.handle_input(PAUSE_MENU, key)
  end
end
