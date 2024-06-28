function Paddle(x, y)
  local speed = 5
  return {
    x = x,
    y = y,
    move = function(self, up, down)
      if love.keyboard.isDown(up) and self.y > 40 then
        self.y = self.y - speed
      end
      if love.keyboard.isDown(down) and self.y < love.graphics.getHeight() - 100 then
        self.y = self.y + speed
      end
    end,
    draw = function(self)
      love.graphics.rectangle('fill', self.x, self.y, 20, 100)
    end,
  }
end

return Paddle
