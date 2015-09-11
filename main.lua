function love.load()
  drawboxes = require 'drawboxes'

  rect1 = drawboxes.Rectangle(10, 10, 500, 500, 'fill', {255, 0, 0, 255})
  rect2 = drawboxes.Rectangle(10, 10, 30, 30, 'line')
  rect2:setCenter(rect1:getCenter())
end

function love.draw()
  rect1:draw()
  rect2:draw()
end
