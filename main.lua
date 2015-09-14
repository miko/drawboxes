function love.load()
  drawboxes = require 'drawboxes'

  image = drawboxes.Image(
    love.graphics.newImage('testImage.png'), 400, 300,
    0, 2, 2, 25, 25
  )
  circle = drawboxes.Circle(400, 300, 10)
  text = drawboxes.Text(love.graphics.newFont(), 'Hello!', 0, 0, 0, 2, 2, 10, 10)
end

function love.update(dt)
  image.sx = image.sx + .1 * dt
  image.sy = image.sy + .2 * dt
  text.sx = text.sx + .1 * dt
  circle:setCenter(image:getBottomRight())
  text:setCenter(image:getCenter())
end

function love.draw()
  image:draw()
  circle:draw()
  text:draw()
end
