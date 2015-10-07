local function removeByValue(t, value)
  for i = #t, 1, -1 do
    if t[i] == value then
      table.remove(t, i)
      break
    end
  end
end

local Base = {}
Base.__index = Base

setmetatable(Base, {
  __call = function(cls, ...)
    local self = setmetatable({}, cls)
    self:new(...)
    return self
  end
})

----I'M SORRY YOU HAVE TO LOOK AT ALL OF THIS----
--public getters (x and y separately)
function Base:getLeft()    return self:_getX(0)  end
function Base:getCenterX() return self:_getX(.5) end
function Base:getRight()   return self:_getX(1)  end
function Base:getTop()     return self:_getY(0)  end
function Base:getCenterY() return self:_getY(.5) end
function Base:getBottom()  return self:_getY(1)  end

--public getters (both x and y)
function Base:getTopLeft()
  return self:_getX(0), self:_getY(0)
end
function Base:getCenter()
  return self:_getX(.5), self:_getY(.5)
end
function Base:getBottomRight()
  return self:_getX(1), self:_getY(1)
end

--public setters (x and y separately)
function Base:setLeft(x)    self:_setX(x, 0)  end
function Base:setCenterX(x) self:_setX(x, .5) end
function Base:setRight(x)   self:_setX(x, 1)  end
function Base:setTop(y)     self:_setY(y, 0)  end
function Base:setCenterY(y) self:_setY(y, .5) end
function Base:setBottom(y)  self:_setY(y, 1)  end

--public setters (both x and y)
function Base:setTopLeft(x, y)
  self:_setX(x, 0)
  self:_setY(y, 0)
end
function Base:setCenter(x, y)
  self:_setX(x, .5)
  self:_setY(y, .5)
end
function Base:setBottomRight(x, y)
  self:_setX(x, 1)
  self:_setY(y, 1)
end
----END OF HORRIBLE THINGS----

local Box = {}
Box.__index = Box

setmetatable(Box, {
  __index = Base,
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

function Box:resize(w, h)
  self.w = w
  self.h = h
end

--internally used get functions, you might want to customize these
function Box:_getX(amount) return self.x + self.w * amount end
function Box:_getY(amount) return self.y + self.h * amount end
function Box:_setX(x, amount) self.x = self.x + x - self:_getX(amount) end
function Box:_setY(y, amount) self.y = self.y + y - self:_getY(amount) end

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
  local children = {...}
  for i = 1, #children do
    self:add(children[i])
  end
end

function Container:relayout()
  local children = self.children
  --get the box around all the objects
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

  --relayout children
  for i = 1, #children do
    local child = children[i]
    child:setLeft(child:getLeft() - self:getLeft())
    child:setTop(child:getTop() - self:getTop())
  end
end

function Container:draw(x, y)
  x, y = x or 0, y or 0
  for i = 1, #self.children do
    self.children[i]:draw(self.x + x, self.y + y)
  end
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
  love.graphics.circle(self.mode, self.x + x, self.y + y, self.r, self.segments)
end

function Circle:resize(r, segments)
  self.r        = r
  self.segments = segments or 100
end


local Image = {}
Image.__index = Image

setmetatable(Image, {
  __index = Box,
  __call = function(cls, ...)
    local self = setmetatable({}, cls)
    self:new(...)
    return self
  end
})

function Image:new(image, x, y, r, sx, sy, ox, oy, kx, ky, color)
  self.image = image
  self.x     = x
  self.y     = y
  self.r     = r or 0
  self.sx    = sx or 1
  self.sy    = sy or self.sx
  self.ox    = ox or 0
  self.oy    = oy or 0
  self.kx    = kx or 0
  self.ky    = ky or 0
  self.color = color or {255, 255, 255, 255}
end

function Image:_getX(amount)
  local left = self.x - self.ox * self.sx
  return left + self.image:getWidth() * self.sx * amount
end

function Image:_getY(amount)
  local top = self.y - self.oy * self.sy
  return top + self.image:getHeight() * self.sy * amount
end

function Image:draw(x, y)
  x, y = x or 0, y or 0
  love.graphics.setColor(self.color)
  love.graphics.draw(self.image, self.x + x, self.y + y, self.r, self.sx, self.sy, self.ox, self.oy, self.kx, self.ky)
end

local Text = {}
Text.__index = Text

setmetatable(Text, {
  __index = Box,
  __call = function(cls, ...)
    local self = setmetatable({}, cls)
    self:new(...)
    return self
  end
})

function Text:new(font, text, x, y, r, sx, sy, ox, oy, kx, ky, color)
  self.font  = font
  self.text  = text
  self.x     = x
  self.y     = y
  self.r     = r or 0
  self.sx    = sx or 1
  self.sy    = sy or self.sx
  self.ox    = ox or 0
  self.oy    = oy or 0
  self.kx    = kx or 0
  self.ky    = ky or 0
  self.color = color or {255, 255, 255, 255}
end

function Text:_getX(amount)
  local left = self.x - self.ox * self.sx
  return left + self.font:getWidth(self.text) * self.sx * amount
end

function Text:_getY(amount)
  local top = self.y - self.oy * self.sy
  return top + self.font:getHeight(self.text) * self.sy * amount
end

function Text:draw(x, y)
  x, y = x or 0, y or 0
  love.graphics.setColor(self.color)
  love.graphics.setFont(self.font)
  love.graphics.print(self.text, self.x + x, self.y + y, self.r, self.sx, self.sy, self.ox, self.oy, self.kx, self.ky)
end

return {
  Box       = Box,
  Container = Container,
  Rectangle = Rectangle,
  Circle    = Circle,
  Image     = Image,
  Text      = Text
}
