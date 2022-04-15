Slice = Object:extend(object);

--[[
a b c
d e f
g h i
]]--

function Slice:new(x, y, width, height, corner, asset)
    self.x = x;
    self.y = y;
    self.width = width;
    self.height = height;
    self.corner = corner;
    self.image = love.graphics.newImage(asset);
    self.scaleX = love.graphics.getWidth();
    self.scaleY = love.graphics.getHeight();

    spriteBatch = love.graphics.newSpriteBatch(self.image, 9);
    local horSide = self.width - self.corner*2;
    local vertSide = self.height - self.corner*2;
    --order a, b, c, d, e, f, g, h, i
    spriteBatch:add(love.graphics.newQuad(0, 0, self.corner, self.corner, self.image), self.x, self.y, 0, 1, 1);
    spriteBatch:add(love.graphics.newQuad(self.corner, 0, self.corner, self.corner, self.image), self.x+self.corner, self.y, 0, horSide/self.corner, 1);
    spriteBatch:add(love.graphics.newQuad(self.corner*2, 0, self.corner, self.corner, self.image), self.x+horSide+self.corner, self.y, 0, 1, 1);
    spriteBatch:add(love.graphics.newQuad(0, self.corner, self.corner, self.corner, self.image), self.x, self.y+self.corner, 0, 1, vertSide/self.corner);
    spriteBatch:add(love.graphics.newQuad(self.corner, self.corner, self.corner, self.corner, self.image), self.x+self.corner, self.y+self.corner, 0, horSide/self.corner, vertSide/self.corner);
    spriteBatch:add(love.graphics.newQuad(self.corner*2, self.corner, self.corner, self.corner, self.image), self.x+horSide+self.corner, self.y+self.corner, 0, 1, vertSide/self.corner);
    spriteBatch:add(love.graphics.newQuad(0, self.corner*2, self.corner, self.corner, self.image), self.x, self.y+self.corner+vertSide, 0, 1, 1);
    spriteBatch:add(love.graphics.newQuad(self.corner, self.corner*2, self.corner, self.corner, self.image), self.x+self.corner, self.y+self.corner+vertSide, 0, horSide/self.corner, 1);
    spriteBatch:add(love.graphics.newQuad(self.corner*2, self.corner*2, self.corner, self.corner, self.image), self.x+horSide+self.corner, self.y+self.corner+vertSide, 0, 1, 1);
end


function Slice:draw()
    love.graphics.draw(spriteBatch);
end
