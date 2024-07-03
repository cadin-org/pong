function MenuOption(text, font, is_highlighted, func, arg)
  return {
    text = text or 'No Text',
    font = font or love.graphics.getFont(),
    is_highlighted = is_highlighted or false,
    func = func or function()
      print 'No function assigned'
    end,
    arg = arg,

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
        love.graphics.setColor(0.8, 0.8, 0.8)
        love.graphics.print('>', self.font, text_x - 50, text_y)
        love.graphics.print(self.text, self.font, text_x, text_y)
      else
        love.graphics.setColor(0.6, 0.6, 0.6)
        love.graphics.print(self.text, self.font, text_x, text_y)
      end
    end,
  }
end

return MenuOption
