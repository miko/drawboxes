local Box = {}
Box.__index = Box

setmetatable(Box, {
  __call = function(cls, ...)
    local self = setmetatable({}, cls)
    self:new(...)
    return self
  end
})

function Box:new(x, y, w, h)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
end

function Box:_getX(amount) return self.x + self.w * amount end
function Box:_getY(amount) return self.y + self.h * amount end
function Box:_get(amountX, amountY)
  return self:_getX(amountX), self:_getY(amountY)
end

function Box:_setX(x, amount) self.x = x - self.w * amount end
function Box:_setY(y, amount) self.y = y - self.h * amount end
function Box:_set(x, y, amountX, amountY)
  self:_setX(x, amountX)
  self:_setY(y, amountY)
end

function Box:getLeft()    return self:_getX(0)  end
function Box:getCenterX() return self:_getX(.5) end
function Box:getRight()   return self:_getX(1)  end
function Box:getTop()     return self:_getY(0)  end
function Box:getCenterY() return self:_getY(.5) end
function Box:getBottom()  return self:_getY(1)  end

function Box:getTopLeft()     return self:_get(0, 0)   end
function Box:getCenter()      return self:_get(.5, .5) end
function Box:getBottomRight() return self:_get(1, 1)   end

function Box:setLeft(x)    self:_setX(x, 0)  end
function Box:setCenterX(x) self:_setX(x, .5) end
function Box:setRight(x)   self:_setX(x, 1)  end
function Box:setTop(y)     self:_setY(y, 0)  end
function Box:setCenterY(y) self:_setY(y, .5) end
function Box:setBottom(y)  self:_setY(y, 1)  end

function Box:setTopLeft(x, y)     self:_set(x, y, 0, 0)   end
function Box:setCenter(x, y)      self:_set(x, y, .5, .5) end
function Box:setBottomRight(x, y) self:_set(x, y, 1, 1)   end

function Box:draw()
  love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

return {Box = Box}
