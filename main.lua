local splash = require 'splash-screen'
local Paddle = require 'paddle'

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
end

function love.update()
  paddles[1]:move('w', 's')
  paddles[2]:move('up', 'down')
end

function love.draw()
  local time = love.timer.getTime()

  splash.start(time)

  if time >= 10 then
    paddles[1]:draw()
    paddles[2]:draw()
  end
end
