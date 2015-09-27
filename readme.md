Drawboxes
=========
Drawboxes is a library that represents drawing operations as boxes and gives you different ways to position those boxes relative to each other.

API
---
### Base class

#### Properties

(none)

#### Functions

`object = drawboxes.Base()`

Returns a new instance of the base class.

The following functions are responsible for all getting and setting of positions. They are left blank by default. If you want to make a custom object directly from the base class, you have to define these yourself. For most cases, you should just use the Box class, which implements these for you.

`Base:_getX(amount)`

Returns an x coordinate on the box. `amount` ranges from 0-1; 0 is the left edge of the box, 1 is the right edge.

`Base:_getY(amount)`

Returns an y coordinate on the box. `amount` ranges from 0-1; 0 is the top edge of the box, 1 is the bottom edge.

`Base:_setX(x, amount)`

Sets the horizontal position of the box so that the horizontal location on the box defined by `amount` is equal to `x`.

`Base:_setY(y, amount)`

Sets the vertical position of the box so that the vertical location on the box defined by `amount` is equal to `y`.

These functions are the public-facing get and set position functions. They rely on `_getX`, `_getY`, `_setX`, and `_setY` to work.

These functions return one coordinate:
- `Base:getLeft()` - Returns the x coordinate of the left edge of the box.
- `Base:getCenterX()` - Returns the x coordinate of the center of the box.
- `Base:getRight()` - Returns the x coordinate of the right edge of the box.
- `Base:getTop()` - Returns the y coordinate of the top edge of the box.
- `Base:getCenterY()` - Returns the y coordinate of the center of the box.
- `Base:getBottom()` - Returns the y coordinate of the bottom edge of the box.

These functions return two coordinates:
- `Base:getTopLeft()` - Returns the x and y coordinates of the top-left corner of the box.
- `Base:getCenter()` - Returns the x and y coordinates of the center of the box.
- `Base:getBottomRight()` - Returns the x and y coordinates of the bottom-right corner of the box.

These functions set one coordinate:
- `Base:setLeft(x)` - Sets the x coordinate of the left edge of the box.
- `Base:setCenterX(x)` - Sets the x coordinate of the center of the box.
- `Base:setRight(x)` - Sets the x coordinate of the right edge of the box.
- `Base:setTop(y)` - Sets the y coordinate of the top edge of the box.
- `Base:setCenterY(y)` - Sets the y coordinate of the center of the box.
- `Base:setBottom(y)` - Sets the y coordinate of the bottom edge of the box.

These functions set two coordinates:
- `Base:setTopLeft(x, y)` - Sets the x and y coordinates of the top-left corner of the box.
- `Base:setCenter(x, y)` - Sets the x and y coordinates of the center of the box.
- `Base:setBottomRight(x, y)` - Sets the x and y coordinates of the bottom-right corner of the box.

### Box class

The main class. It's just the base class, except with `x`, `y`, `w`, and `h` properties and predefined `_getX`, `_getY`, `_setX`, and `_setY` functions. This is a good choice for any object that can be defined by x, y, w, and h.

#### Properties
- `x` is the x coordinate of the left edge of the box.
- `y` is the y coordinate of the top edge of the box.
- `w` is the width of the box.
- `h` is the height of the box.

#### Functions

`box = drawboxes.Box(x, y, w, h)`

Returns a new box.
- `x` is the x coordinate of the left edge of the box.
- `y` is the y coordinate of the top edge of the box.
- `w` is the width of the box.
- `h` is the height of the box.

### Container class

Containers are boxes that hold other boxes. I know, right?

**Implements:** Box

#### Functions

`container = drawboxes.Container(x, y, w, h)`

Returns a new container.

`container:add(...)`

Adds objects to the container.

`container:remove(child)`

Removes an object from the container.

`container:wrap(...)`

Automatically repositions and resizes the container to tightly surround all specified objects, adds the objects to the container, and repositions the objects relative to the container's position.

`container:draw()`

Draws all child objects.

**Note:** The container's child objects are drawn relative to the position of the container.

### Rectangle class

Draws a rectangle.

**Implements:** Box

#### Properties
- `x` is the x coordinate of the left edge of the rectangle.
- `y` is the y coordinate of the top edge of the rectangle.
- `w` is the width of the rectangle.
- `h` is the height of the rectangle.
- `mode` is the draw mode of the rectangle. Should be either "fill" or "line".
- `color` is the color of the rectangle. Should be a table with four numbers from 1-255 (r, g, b, a).

#### Functions

`rectangle = drawboxes.Rectangle(x, y, w, h, mode, color)`

Returns a new rectangle.
- `x` is the x coordinate of the left edge of the rectangle.
- `y` is the y coordinate of the top edge of the rectangle.
- `w` is the width of the rectangle.
- `h` is the height of the rectangle.
- `mode` is the draw mode of the rectangle. (default: `"fill"`)
- `color` is the color of the rectangle. (default: '{255, 255, 255, 255}')

`rectangle:draw()`

Draws the rectangle.

### Circle class

Draws a circle.

**Implements:** Box

#### Properties
- `x` is the x coordinate of the center of the circle.
- `y` is the y coordinate of the center of the circle.
- `r` is the radius of the circle.
- `segments` is the number of segments to draw the circle with.
- `mode` is the draw mode of the circle (should be either "fill" or "line").
- `color` is the color of the circle. Should be a table with four numbers from 1-255 (r, g, b, a).

#### Functions

`circle = drawboxes.Circle(x, y, r, segments, mode, color)`
- `x` is the x coordinate of the center of the circle.
- `y` is the y coordinate of the center of the circle.
- `r` is the radius of the circle.
- `segments` is the number of segments to draw the circle with. (default: `100`)
- `mode` is the draw mode of the circle. (default: `"fill"`)
- `color` is the color of the circle. (default: `{255, 255, 255, 255}`)

`circle:draw()`

Draws the circle.

### Image class

Draws an image.

**Implements:** Box

#### Properties
- `image` is the image to draw.
- `x` is the x coordinate of the image.
- `y` is the y coordinate of the image.
- `r` is the rotation of the image.
- `sx` is the horizontal scale of the image.
- `sy` is the vertical scale of the image.
- `ox` is the horizontal offset of the image (in pixels).
- `oy` is the vertical offset of the image (in pixels).
- `kx` is the horizontal shearing factor of the image.
- `ky` is the vertical shearing factor of the image.
- `color` is the color of the image. Should be a table with four numbers from 1-255 (r, g, b, a).

#### Functions

`image = drawboxes.Image(image, x, y, r, sx, sy, ox, oy, kx, ky, color)`

Returns an image.
- `image` is the image to draw.
- `x` is the x coordinate of the image.
- `y` is the y coordinate of the image.
- `r` is the rotation of the image. (default: `0`)
- `sx` is the horizontal scale of the image. (default: `1`)
- `sy` is the vertical scale of the image. (default: `sx`)
- `ox` is the horizontal offset of the image (in pixels). (default: `0`)
- `oy` is the vertical offset of the image (in pixels). (default: `0`)
- `kx` is the horizontal shearing factor of the image. (default: `0`)
- `ky` is the vertical shearing factor of the image. (default: `0`)
- `color` is the color of the image. (default: `{255, 255, 255, 255}`)

`image:draw()`

Draws the image.

### Text class

Draws text.

**Implements:** Box

#### Properties
- `font` is the font to use.
- `text` is the text to print.
- `x` is the x coordinate of the text.
- `y` is the y coordinate of the text.
- `r` is the rotation of the text.
- `sx` is the horizontal scale of the text.
- `sy` is the vertical scale of the text.
- `ox` is the horizontal offset of the text (in pixels).
- `oy` is the vertical offset of the text (in pixels).
- `kx` is the horizontal shearing factor of the text.
- `ky` is the vertical shearing factor of the text.
- `color` is the color of the text. Should be a table with four numbers from 1-255 (r, g, b, a).

#### Functions

`text = drawboxes.Text(image, x, y, r, sx, sy, ox, oy, kx, ky, color)`

Returns an image.
- `font` is the font to use.
- `text` is the text to print.
- `x` is the x coordinate of the text.
- `y` is the y coordinate of the text.
- `r` is the rotation of the text. (default: `0`)
- `sx` is the horizontal scale of the text. (default: `1`)
- `sy` is the vertical scale of the text. (default: `sx`)
- `ox` is the horizontal offset of the text (in pixels). (default: `0`)
- `oy` is the vertical offset of the text (in pixels). (default: `0`)
- `kx` is the horizontal shearing factor of the text. (default: `0`)
- `ky` is the vertical shearing factor of the text. (default: `0`)
- `color` is the color of the text. (default: `{255, 255, 255, 255}`)

`text:draw()`

Draws the text.
