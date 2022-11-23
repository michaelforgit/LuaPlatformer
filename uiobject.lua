UIObject = Object:extend()
function UIObject:new(x, y, width, height, color, funct, arguments)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.clickable = clickable
    self.text = "Default"
    self.alignText = "left"
    if color == "red" then
        self.color = {255/255, 0, 0}
    elseif color == "green" then
        self.color = {0, 255/255, 0}
    elseif color == "blue" then
        self.color = {0, 0, 255/255}
    elseif color == "pink" then
        self.color = {255/255, 0, 255/255}
    end
    print("self.color is..")
    print(self.color)
    self.scaleX = (love.graphics.getWidth())
    self.scaleY = (love.graphics.getHeight())
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
end

function UIObject:draw()
    love.graphics.setColor(0, 0, 0);
    love.graphics.printf(self.text, self.x, self.y+self.height/2-10, self.width, self.textAlign);
    love.graphics.setColor(1, 1, 1);
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

function UIObject:setText(text)
    self.text = text
end

function UIObject:setTextAlign(align)
    print("JHERE")
    self.textAlign = align
end


UIButton = UIObject:extend()

function UIButton:new(x, y, width, height, color, funct, arguments)
    UIButton.super.new(self, x, y, width, height, color, funct, arguments)
    self.slice = Slice(self.x, self.y, self.width, self.height, 16, "assets/images/button.png", self.color)
end

function UIButton:draw()
    self.slice:draw()
    UIButton.super.draw(self)
end

function UIButton:mousepressed(mouseX, mouseY, button)
    if mouseX >= self.x and mouseX <= self.x+self.width and mouseY >= self.y and mouseY <= self.y+self.height then
        print("Within bounds...")
        self.click()
    end
end

UIButtonClosable = UIButton:extend()

function UIButtonClosable:new(x, y, width, height, color, funct, arguments)
    UIButtonClosable.super.new(self, x, y, width, height, color, funct, arguments)
    self.closeSize = 25
end

function UIButtonClosable:draw()
    UIButtonClosable.super.draw(self)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", self.x+self.width-self.closeSize, self.y, self.closeSize, self.closeSize)
    love.graphics.setColor(1, 1, 1)
end

function UIButtonClosable:mousepressed(mouseX, mouseY, button)
    if mouseX >= self.x+self.width-self.closeSize and mouseX <=self.x+self.width and mouseY >= self.y and mouseY <= self.y+self.closeSize then
        self.remove = true
    else
        if mouseX >= self.x and mouseX <= self.x+self.width and mouseY >= self.y and mouseY <= self.y+self.height then
            print("Within bounds...")
            self.click()
        end
    end
end