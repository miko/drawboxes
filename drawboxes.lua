local function removeByValue(t, value)
  for i = #t, 1, -1 do
    if t[i] == value then
      table.remove(t, i)
      break
    end
  end
end

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

--internally used get functions, you might want to customize these
function Box:_getX(amount) return self.x + self.w * amount end
function Box:_getY(amount) return self.y + self.h * amount end

--internally used set functions, these should work for any objects with x and y properties
function Box:_setX(x, amount) self.x = self.x + x - self:_getX(amount) end
function Box:_setY(y, amount) self.y = self.y + y - self:_getY(amount) end

--internally used shortcut functions, you shouldn't need to change these
function Box:_get(amountX, amountY)
  return self:_getX(amountX), self:_getY(amountY)
end
function Box:_set(x, y, amountX, amountY)
  self:_setX(x, amountX)
  self:_setY(y, amountY)
end

----I'M SORRY YOU HAVE TO LOOK AT ALL OF THIS----
--public getters (x and y separately)
function Box:getLeft()    return self:_getX(0)  end
function Box:getCenterX() return self:_getX(.5) end
function Box:getRight()   return self:_getX(1)  end
function Box:getTop()     return self:_getY(0)  end
function Box:getCenterY() return self:_getY(.5) end
function Box:getBottom()  return self:_getY(1)  end

--public getters (both x and y)
function Box:getTopLeft()     return self:_get(0, 0)   end
function Box:getCenter()      return self:_get(.5, .5) end
function Box:getBottomRight() return self:_get(1, 1)   end

--public setters (x and y separately)
function Box:setLeft(x)    self:_setX(x, 0)  end
function Box:setCenterX(x) self:_setX(x, .5) end
function Box:setRight(x)   self:_setX(x, 1)  end
function Box:setTop(y)     self:_setY(y, 0)  end
function Box:setCenterY(y) self:_setY(y, .5) end
function Box:setBottom(y)  self:_setY(y, 1)  end

--public setters (both x and y)
function Box:setTopLeft(x, y)     self:_set(x, y, 0, 0)   end
function Box:setCenter(x, y)      self:_set(x, y, .5, .5) end
function Box:setBottomRight(x, y) self:_set(x, y, 1, 1)   end
----END OF HORRIBLE THINGS----

function Box:draw(x, y)
  x, y = x or 0, y or 0
  --just for debugging, take me out later!
  love.graphics.rectangle('line', self.x + x, self.y + y, self.w, self.h)
end

local Container = {}
Container.__index = Container

setmetatable(Container, {
  __index = Box,
  __call = function(cls, ...)
    local self = setmetatable({}, cls)
    self:new(...)
    return self
  end
})

function Container:new(x, y, w, h)
  Box.new(self, x, y, w, h)
  self.children = {}
end

function Container:add(...)
  local children = {...}
  for i = 1, #children do
    table.insert(self.children, children[i])
  end
end

function Container:remove(child)
  removeByValue(self.children, child)
end

function Container:wrap(...)
  --get the box around all the objects
  local children = {...}
  local x1, y1 = children[1]:getTopLeft()
  local x2, y2 = children[1]:getBottomRight()
  for i = 2, #children do
    local child = children[i]
    if child:getLeft() < x1 then x1 = child:getLeft() end
    if child:getTop() < y1 then y1 = child:getTop() end
    if child:getRight() > x2 then x2 = child:getRight() end
    if child:getBottom() > y2 then y2 = child:getBottom() end
  end

  self.x, self.y, self.w, self.h = x1, y1, x2 - x1, y2 - y1

  --add the objects
  for i = 1, #children do
    local child = children[i]
    child:setLeft(child:getLeft() - self:getLeft())
    child:setTop(child:getTop() - self:getTop())
    self:add(child)
  end
end

function Container:draw(x, y)
  x, y = x or 0, y or 0
  for i = 1, #self.children do
    self.children[i]:draw(self.x, self.y)
  end
  --just for debugging, take me out later
  love.graphics.rectangle('line', self.x + x, self.y + y, self.w, self.h)
end

local Rectangle = {}
Rectangle.__index = Rectangle

setmetatable(Rectangle, {
  __index = Box,
  __call = function(cls, ...)
    local self = setmetatable({}, cls)
    self:new(...)
    return self
  end
})

function Rectangle:new(x, y, w, h, mode, color)
  Box.new(self, x, y, w, h)
  self.mode  = mode or 'fill'
  self.color = color or {255, 255, 255, 255}
end

function Rectangle:draw(x, y)
  x, y = x or 0, y or 0
  love.graphics.setColor(self.color)
  love.graphics.rectangle(self.mode, self.x + x, self.y + y, self.w, self.h)
end

local Circle = {}
Circle.__index = Circle

setmetatable(Circle, {
  __index = Box,
  __call = function(cls, ...)
    local self = setmetatable({}, cls)
    self:new(...)
    return self
  end
})

function Circle:new(x, y, r, segments, mode, color)
  self.x        = x
  self.y        = y
  self.r        = r
  self.segments = segments or 100
  self.mode     = mode or 'fill'
  self.color    = color or {255, 255, 255, 255}
end

function Circle:_getX(amount) return self.x - self.r + self.r * 2 * amount end
function Circle:_getY(amount) return self.y - self.r + self.r * 2 * amount end

function Circle:draw(x, y)
  x, y = x or 0, y or 0
  love.graphics.setColor(self.color)
  love.graphics.circle(self.mode, self.x, self.y, self.r, self.segments)
end


return {
  Box       = Box,
  Container = Container,
  Rectangle = Rectangle,
  Circle    = Circle
}
