function love.load()
  drawboxes = require 'drawboxes'

  box1 = drawboxes.Box(300, 300, 50, 50)
  box2 = drawboxes.Box(100, 100, 300, 200)

  box2:setBottomRight(box1:getBottomRight())
  box1:setLeft(box2:getRight())
end

function love.draw()
  box1:draw()
  box2:draw()
end
