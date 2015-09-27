function love.load()
  drawboxes = require 'drawboxes'

  font1 = love.graphics.newFont('kenpixel.ttf', 30)
  font2 = love.graphics.newFont('kenvector_future.ttf', 60)

  mainContainer = drawboxes.Container(0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  text1 = drawboxes.Text(font1, 'Hello', 0, 0)
  text2 = drawboxes.Text(font2, 'World!', 0, 0)
  text2:setLeft(text1:getRight())
  text2:setCenterY(text1:getCenterY())

  textContainer = drawboxes.Container(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  textContainer:wrap(text1, text2)
  textContainer:setCenter(400, 300)
  mainContainer:add(textContainer)
end

function love.draw()
  mainContainer:draw()
end
