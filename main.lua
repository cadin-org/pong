local splash = require 'splash-screen'
local Paddle = require 'components.paddle'
local menu = require 'components.menu'
local game_screen = require 'components.game-screen'
local ball = require 'components.ball'
local scoreboard = require 'components.scoreboard'
local menu_pause = require 'components.menu-pause'
local handle_key_press = require 'utils.input'

local paddles = {
  Paddle:new(0, (love.graphics.getHeight() / 2) - 50),
  Paddle:new(love.graphics.getWidth() - 20, (love.graphics.getHeight() / 2) - 50),
}

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

function love.load()
  local r, g, b = love.math.colorFromBytes(24, 24, 37)
  love.graphics.setBackgroundColor(r, g, b)

  local font_asset_path = 'assets/fonts/FiraMono-Medium.ttf'
  local fira_mono = love.graphics.newFont(font_asset_path, 48)
  love.graphics.setFont(fira_mono)

  splash.new(400, 400)

  menu.load()
end

function love.update(dt)
  if menu.game_states.playing then
    paddles[1]:move('w', 's')
    paddles[2]:move('up', 'down')
    ball.move(paddles[1], paddles[2], dt)
  end
end

function love.draw()
  local time = love.timer.getTime()
  -- splash.start(time)

  if time >= 0 then
    if menu.game_states.standard then
      menu.draw()
    elseif menu.game_states.pause then
      menu_pause.draw()
    else
      love.graphics.printf('press "p" to pause the game', love.graphics.newFont(15), 0, 10, love.graphics.getWidth(), 'center')
      game_screen.draw()
      ball.draw()
      paddles[1]:draw()
      paddles[2]:draw()
      scoreboard.draw(paddles[1], paddles[2])
    end
  end
end

function love.keypressed(key)
  handle_key_press.keypressed(key)
end
