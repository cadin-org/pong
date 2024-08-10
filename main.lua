local splash = require 'libcadin.splash-screen'
local window = require 'libcadin.window'
local game_screen = require 'libcadin.game-screen'
local Paddle = require 'components.paddle'
local menu = require 'components.menu'
local playfield = require 'components.playfield'
local ball = require 'components.ball'
local scoreboard = require 'components.scoreboard'

-- single_player, multiplayer
GAME_MODE = 'single_player'

-- title_screen, pause_screen, playing, gameover
GAME_STATE = 'title_screen'

function IS_UP_KEY(key)
  local keys_table = { 'k', 'w', 'up' }
  for _, up_key in pairs(keys_table) do
    if key == up_key then
      return true
    end
  end
  return false
end

function IS_DOWN_KEY(key)
  local keys_table = { 'j', 's', 'down' }
  for _, down_key in pairs(keys_table) do
    if key == down_key then
      return true
    end
  end
  return false
end

local paddles = {
  Paddle:new(game_screen.pos_x, window.center.y - 50),
  Paddle:new(game_screen.pos_x + game_screen.width - 20, window.center.y - 50),
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
  MAIN_MENU = menu.load_main_options()
  PAUSE_MENU = menu.load_pause_options()

  local r, g, b = love.math.colorFromBytes(24, 24, 37)
  love.graphics.setBackgroundColor(r, g, b)

  local font_asset_path = 'assets/fonts/FiraMono-Medium.ttf'
  local fira_mono = love.graphics.newFont(font_asset_path, 48)
  love.graphics.setFont(fira_mono)

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
  splash.start(time)

  if time >= 12 then
    if GAME_STATE == 'title_screen' then
      menu.draw(MAIN_MENU)
    elseif GAME_STATE == 'pause_screen' then
      menu.draw(PAUSE_MENU)
    elseif GAME_STATE == 'playing' then
      love.graphics.printf('press "p" to pause the game', love.graphics.newFont(15), 0, 100, window.width, 'center')
      playfield.draw()
      ball.draw()
      paddles[1]:draw()
      paddles[2]:draw()
      scoreboard.draw(paddles[1], paddles[2])
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
