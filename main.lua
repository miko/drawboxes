function love.load()
  drawboxes = require 'drawboxes'

  local lg = love.graphics

  --load some fonts
  font1 = lg.newFont('kenpixel.ttf', 30)
  font2 = lg.newFont('kenvector_future.ttf', 60)

  --this container holds everything else and takes care of the screen size
  mainContainer = drawboxes.Container(0, 0, lg.getWidth(), lg.getHeight())

  --make some text objects
  text1 = drawboxes.Text(font1, 'Hello', 0, 0)
  text2 = drawboxes.Text(font2, 'World!', 0, 0)

  --position text2 relative to text1
  text2:setLeft(text1:getRight())
  text2:setCenterY(text1:getCenterY())

  --center the text on the screen
  textContainer = drawboxes.Container(0, 0, lg.getWidth(), lg.getHeight())
  textContainer:wrap(text1, text2)
  textContainer:setCenter(mainContainer:getCenter())

  mainContainer:add(textContainer)
end

function love.draw()
  mainContainer:draw()
end
