local splash = require 'splash-screen'
local Paddle = require 'components.paddle'
local menu = require 'components.menu'
local game_screen = require 'components.game-screen'
local ball = require 'components.ball'

local paddles = {
  Paddle(0, (love.graphics.getHeight() / 2) - 50),
  Paddle(love.graphics.getWidth() - 20, (love.graphics.getHeight() / 2) - 50),
}

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
  splash.start(time)

  if time >= 10 then
    if menu.game_states.standard then
      menu.draw()
    else
      game_screen.draw()
      ball.draw()
      paddles[1]:draw()
      paddles[2]:draw()
    end
  end
end
