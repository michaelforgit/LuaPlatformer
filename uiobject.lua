UIObject = Object:extend()
function UIObject:new(x, xOffset, y, yOffset, width, wOffset, height, hOffset)
    self.x = x
    self.xOffset = xOffset
    self.y = y
    self.yOffset = yOffset
    self.width = width
    self.wOffset = wOffset
    self.height = height
    self.hOffset = hOffset
    self.clickable = clickable
    self.alignText = "left"
    self.color = {0, 0, 0, 1}
    self.trueX = self.x*love.graphics.getWidth() + self.xOffset
    self.trueY = self.y*love.graphics.getHeight() + self.yOffset
    self.trueW = self.width*love.graphics.getWidth() + self.wOffset
    self.trueH = self.height*love.graphics.getHeight() + self.hOffset
end

function UIObject:draw()
    love.graphics.setColor(0, 0, 0);
    if self.text then
        love.graphics.setNewFont(30);
        love.graphics.printf(self.text, self.trueX, self.trueY+self.trueH/2-10, self.trueW, self.textAlign);
    end
    if self.image then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.image, self.trueX, self.trueY, 0, self.trueW/self.image:getWidth(), self.trueH/self.image:getHeight());
    end
    love.graphics.setColor(self.color);
    -- love.graphics.rectangle("line", self.trueX, self.trueY, self.trueW, self.trueH) --Uncomment to view UIObject boundaries
    love.graphics.setColor(1, 1, 1)
end

-- function UIObject:resize()
--     --love.graphics.setFont(love.graphics.newFont("assets/fonts/Abaddon Light.ttf", 20+(love.graphics.getWidth()/self.scaleX)));
--     self.width = self.width * love.graphics.getWidth()/self.scaleX;
--     self.height = self.height * love.graphics.getHeight()/self.scaleY;
--     self.x = self.x * love.graphics.getWidth()/self.scaleX;
--     self.y = self.y * love.graphics.getHeight()/self.scaleY;
--     self.scaleY = love.graphics.getHeight();
--     self.scaleX = love.graphics.getWidth();
--     self.slicedImage = Slice(self.x, self.y, self.width, self.height, 16, "assets/images/red.png")
--     print("RESIZED")
-- end

function UIObject:update(dt)

end

function UIObject:getX()
    return self.trueX
end

function UIObject:getY()
    return self.trueY
end

function UIObject:getWidth()
    return self.trueW
end

function UIObject:getHeight()
    return self.trueH
end

function UIObject:setParent(parent)
    print("setting parent")
    self.parent = parent
    self.trueX = self.parent:getX() + (self.parent:getWidth())*self.x + self.xOffset
    self.trueY = self.parent:getY() + (self.parent:getHeight())*self.y + self.yOffset
    self.trueW = (self.parent:getWidth())*self.width + self.wOffset
    self.trueH = (self.parent:getHeight())*self.height + self.hOffset
end

function UIObject:setText(text, align)
    self.text = text
    self.textAlign = align
end

function UIObject:setColor(color)
    if color == "red" then
        print("COLOR IS RED")
        self.color = {255/255, 0, 0}
    elseif color == "green" then
        self.color = {0, 255/255, 0}
    elseif color == "blue" then
        self.color = {0, 0, 255/255}
    elseif color == "pink" then
        self.color = {255/255, 0, 255/255}
    end
end

function UIObject:setImage(image)
    self.image = image
end

UIButton = UIObject:extend()

function UIButton:new(x, xOffset, y, yOffset, width, wOffset, height, hOffset, funct, arguments)
    UIButton.super.new(self, x, xOffset, y, yOffset, width, wOffset, height, hOffset)
    self.funct = funct
    self.arguments = arguments
    self.click = function()
        if self.funct then
            if self.arguments then
                self.funct(unpack(self.arguments))
            else
                print("NO ARGS")
                self.funct()
            end
        end
    end
    print(self.trueH)
    self.slice = Slice(self.trueX, self.trueY, self.trueW, self.trueH, 16, "assets/images/button.png", self.color)
end

function UIButton:setParent(parent)
    UIButton.super.setParent(self, parent)
    self.slice = Slice(self.trueX, self.trueY, self.trueW, self.trueH, 16, "assets/images/button.png", self.color)
end

function UIButton:draw()
    self.slice:draw()
    UIButton.super.draw(self)
end

function UIButton:mousepressed(mouseX, mouseY, button)
    if mouseX >= self.trueX and mouseX <= self.trueX+self.trueW and mouseY >= self.trueY and mouseY <= self.trueY+self.trueH then
        print("Within bounds...")
        self.click()
    end
end

function UIButton:setColor(color)
    print("Set Color Called")
    UIButton.super.setColor(self, color)
    print(unpack(self.color))
    self.slice = Slice(self.trueX, self.trueY, self.trueW, self.trueH, 16, "assets/images/button.png", self.color)  --Must make a new slice to change color because setColor() needs to be called before the slice is created
end

UIButtonClosable = UIButton:extend()

function UIButtonClosable:new(x, xOffset, y, yOffset, width, wOffset, height, hOffset, funct, arguments)
    UIButtonClosable.super.new(self, x, xOffset, y, yOffset, width, wOffset, height, hOffset, funct, arguments)
    self.closeSize = 25
end

function UIButtonClosable:draw()
    UIButtonClosable.super.draw(self)
end

function UIButtonClosable:mousepressed(mouseX, mouseY, button)
    if mouseX >= self.trueX+self.trueW-self.closeSize and mouseX <=self.trueX+self.trueW and mouseY >= self.trueY and mouseY <= self.trueY+self.closeSize then
        self.remove = true
    else
        UIButtonClosable.super.mousepressed(self, mouseX, mouseY, button)
    end
end