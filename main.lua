function love.load()
  drawboxes = require 'drawboxes'

  circle = drawboxes.Circle(100, 200, 100, 100, 'fill', {255, 0, 0, 255})
  rect2 = drawboxes.Rectangle(10, 10, 30, 30, 'line')
  rect2:setCenter(circle:getRight(), circle:getCenterY())
end

function love.draw()
  circle:draw()
  rect2:draw()
end
