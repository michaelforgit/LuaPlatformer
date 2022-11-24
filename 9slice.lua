Slice = Object:extend()
--[[
a b c
d e f
g h i
]]--

function Slice:new(x, y, width, height, corner, asset, color)
    self.x = x;
    self.y = y;
    self.width = width;
    self.height = height;
    self.corner = corner;
    self.image = love.graphics.newImage(asset);

    self.spriteBatch = love.graphics.newSpriteBatch(self.image, 9);
    local horSide = self.width - self.corner*2;
    local vertSide = self.height - self.corner*2;
    --order a, b, c, d, e, f, g, h, i
    self.spriteBatch:setColor(color)
    self.spriteBatch:add(love.graphics.newQuad(0, 0, self.corner, self.corner, self.image), self.x, self.y, 0, 1, 1);  --a
    self.spriteBatch:add(love.graphics.newQuad(self.corner, 0, self.corner, self.corner, self.image), self.x+self.corner, self.y, 0, horSide/self.corner, 1); --b
    self.spriteBatch:add(love.graphics.newQuad(self.corner*2, 0, self.corner, self.corner, self.image), self.x+horSide+self.corner, self.y, 0, 1, 1);  --c
    self.spriteBatch:add(love.graphics.newQuad(0, self.corner, self.corner, self.corner, self.image), self.x, self.y+self.corner, 0, 1, vertSide/self.corner);  --d
    self.spriteBatch:add(love.graphics.newQuad(self.corner, self.corner, self.corner, self.corner, self.image), self.x+self.corner, self.y+self.corner, 0, horSide/self.corner, vertSide/self.corner);  --e
    self.spriteBatch:add(love.graphics.newQuad(self.corner*2, self.corner, self.corner, self.corner, self.image), self.x+horSide+self.corner, self.y+self.corner, 0, 1, vertSide/self.corner); --f
    self.spriteBatch:add(love.graphics.newQuad(0, self.corner*2, self.corner, self.corner, self.image), self.x, self.y+self.corner+vertSide, 0, 1, 1);  --g
    self.spriteBatch:add(love.graphics.newQuad(self.corner, self.corner*2, self.corner, self.corner, self.image), self.x+self.corner, self.y+self.corner+vertSide, 0, horSide/self.corner, 1);  --h
    self.spriteBatch:add(love.graphics.newQuad(self.corner*2, self.corner*2, self.corner, self.corner, self.image), self.x+horSide+self.corner, self.y+self.corner+vertSide, 0, 1, 1);  --i
end

function Slice:draw()
    love.graphics.draw(self.spriteBatch);
end

function Slice:update()

end

function Slice:resize()

end

function Slice:mousepressed(x, y, button)
    print("hello world")
end