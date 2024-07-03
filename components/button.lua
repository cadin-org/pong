function MenuOption(text, font, is_highlighted, func, arg, width, height)
  return {
    text = text or 'No Text',
    font = font or love.graphics.getFont(),
    is_highlighted = is_highlighted or false,
    func = func or function()
      print 'No function assigned to button'
    end,
    arg = arg,
    width = width or 300,
    height = height or 100,

    button_x = 0,
    button_y = 0,
    text_x = 0,
    text_y = 0,

    shift_highlight = function(self)
      self.is_highlighted = not self.is_highlighted
    end,

    select_option_if_highlighted = function(self)
      if self.is_highlighted then
        self.func(arg)
      end
    end,

    draw = function(self, text_x, text_y)
      if self.is_highlighted then
        love.graphics.print('>', self.font, text_x - 50, text_y)
      end

      self.text_x = text_x + self.button_x
      self.text_y = text_y + self.button_y

      love.graphics.setColor(1, 1, 1)
      love.graphics.print(self.text, self.font, self.text_x, self.text_y)

      love.graphics.setColor(1, 1, 1)
    end,
  }
end

return MenuOption
