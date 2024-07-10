local MenuOption = {}
MenuOption.__index = MenuOption

local hl_color = { 205, 214, 244 }
local non_hl_color = { 108, 112, 134 }
local hl_arrow = '> '

function MenuOption:new(text, font, func, arg, is_hl)
  local instance = setmetatable({}, MenuOption)
  instance.text = text
  instance.font = font
  instance.func = func
  instance.arg = arg
  instance.is_hl = is_hl
  instance.text_color = is_hl and hl_color or non_hl_color
  instance.arrow = is_hl and hl_arrow or ''
  return instance
end

function MenuOption:shift_hl()
  self.is_hl = not self.is_hl
  if self.is_hl then
    self.text_color = hl_color
    self.arrow = hl_arrow
  else
    self.text_color = non_hl_color
    self.arrow = ''
  end
end

local function get_colored_text(rgb, text)
  local r, g, b = love.math.colorFromBytes(rgb[1], rgb[2], rgb[3])
  return { { r, g, b }, text }
end

local function get_text_properties(text, font)
  local text_height = font:getHeight()
  local text_width = font:getWidth(text)

  local pos_x = (love.graphics.getWidth() - text_width) / 2
  local pos_y = (love.graphics.getHeight() - text_height) / 2

  return pos_x, pos_y, text_height, text_width
end

function MenuOption:select_option()
  self.func(self.arg)
end

function MenuOption:draw(pos_factor)
  local pos_x, pos_y, text_height = get_text_properties(self.text, self.font)
  local text = get_colored_text(self.text_color, self.arrow .. self.text)

  love.graphics.print(text, self.font, pos_x - self.font:getWidth(self.arrow), pos_y + (text_height * pos_factor))
end

return MenuOption
