local splash = require 'splash-screen'

function love.load()
  local r, g, b = love.math.colorFromBytes(24, 24, 37)
  love.graphics.setBackgroundColor(r, g, b)

  local font_asset_path = 'assets/fonts/FiraMono-Medium.ttf'
  local fira_mono = love.graphics.newFont(font_asset_path, 48)
  love.graphics.setFont(fira_mono)

  splash.new(400, 400)
end

function love.draw()
  local time = love.timer.getTime()

  splash.start(time)
end
