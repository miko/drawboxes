Drawboxes
=========
Drawboxes is a library that represents drawing operations as boxes and gives you different ways to position those boxes relative to each other.

API
---
### Base class

#### Properties

(none)

#### Functions

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
