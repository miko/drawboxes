function love.load()
  drawboxes = require 'drawboxes'

  box1 = drawboxes.Box(300, 300, 50, 50)
  box2 = drawboxes.Box(100, 100, 300, 200)

  box2:setBottomRight(box1:getBottomRight())
  box1:setLeft(box2:getRight())

  container = drawboxes.Container(100, 0, 800, 600)
  container:wrap(box1, box2, drawboxes.Box(400, 500, 50, 50))
end

function love.draw()
  container:draw()
end
