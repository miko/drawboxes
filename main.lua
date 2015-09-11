function love.load()
  drawboxes = require 'drawboxes'

  image = drawboxes.Image(
    love.graphics.newImage('testImage.png'), 400, 300,
    0, 2, 2, 25, 25
  )
  circle = drawboxes.Circle(400, 300, 10)
  circle:setCenter(image:getBottomRight())
end

function love.update(dt)
  image.sx = image.sx + .1 * dt
  image.sy = image.sy + .2 * dt
  circle:setCenter(image:getBottomRight())
end

function love.draw()
  image:draw()
  circle:draw()
end
