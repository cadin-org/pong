function Button(text, func, arg, width, height)
  return {
    width = width or 100,
    height = height or 100,
    func = func or function()
      print 'No function assigned to button'
    end,

    arg = arg,
    text = text or 'No Text',
    button_x = 0,
    button_y = 0,
    text_x = 0,
    text_y = 0,

    check_click = function(self, mouse_x, mouse_y)
      if (mouse_x >= self.button_x) and (mouse_x <= self.button_x + self.width) then
        if (mouse_y >= self.button_y) and (mouse_y <= self.button_y + self.height) then
          if self.arg then
            self.func(self.arg)
          else
            self.func()
          end
        end
      end
    end,

    draw = function(self, button_x, button_y, text_x, text_y)
      self.button_x = button_x or self.button_x
      self.button_y = button_y or self.button_y
      self.text_x = text_x + self.button_x
      self.text_y = text_y + self.button_y

      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.rectangle('fill', self.button_x, self.button_y, self.width, self.height)

      love.graphics.setColor(1, 1, 1)
      love.graphics.print(self.text, self.text_x, self.text_y)

      love.graphics.setColor(1, 1, 1)
    end,
  }
end

return Button
