UIObject = Object:extend()
function UIObject:new(x, y, width, height, closeSize, text, color, funct, arguments)
    print("HERE IS A NEW UIOBJECT")
    self.x = x
    self.y = y
    --self.width = math.max(350, specs[3]);
    self.width = width
    self.height = height
    self.closeSize = closeSize  --Set to 0 if you do not want a close option.
    self.clickable = clickable
    self.text = text
    if color == "red" then
        self.color = {255, 0, 0}
    elseif color == "green" then
        self.color = {0, 255, 0}
    elseif color == "blue" then
        self.color = {0, 0, 255}
    end
    print("self.color is..")
    print(self.color)
    self.scaleX = (love.graphics.getWidth())
    self.scaleY = (love.graphics.getHeight())
    self.slicedImage = Slice(self.x, self.y, self.width, self.height, 16, "assets/images/red.png")
    self.funct = funct
    self.arguments = arguments
    self.click = function()
        print("HERE")
        if self.funct then
            print("CLICKED")
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
    love.graphics.setColor(self.color or {255, 255, 255})
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height);
    love.graphics.setColor(0, 0, 0);
    love.graphics.printf(self.text, self.x+20, self.y+20, self.width-40, "left");
    love.graphics.setColor(1, 1, 1);
    if self.closeSize > 0 then
        love.graphics.setColor(255/255, 0, 0);
        love.graphics.rectangle("fill", self.x+self.width-self.closeSize, self.y, self.closeSize, self.closeSize);
        love.graphics.setColor(0, 0, 0);
        love.graphics.printf("X", self.x+self.width-self.closeSize, self.y+love.graphics.getFont():getHeight()/2, self.closeSize, "center");
        love.graphics.setColor(1, 1, 1);
    end
end

function UIObject:resize()
    --love.graphics.setFont(love.graphics.newFont("assets/fonts/Abaddon Light.ttf", 20+(love.graphics.getWidth()/self.scaleX)));
    self.width = self.width * love.graphics.getWidth()/self.scaleX;
    self.height = self.height * love.graphics.getHeight()/self.scaleY;
    self.x = self.x * love.graphics.getWidth()/self.scaleX;
    self.y = self.y * love.graphics.getHeight()/self.scaleY;
    self.scaleY = love.graphics.getHeight();
    self.scaleX = love.graphics.getWidth();
    self.slicedImage = Slice(self.x, self.y, self.width, self.height, 16, "assets/images/red.png")
    print("RESIZED")
end

function UIObject:update(dt)

end

function UIObject:mousepressed(mouseX, mouseY, button)
    if self.closeSize > 0 then
        if mouseX >= self.x+self.width-self.closeSize and mouseX <=self.x+self.width and mouseY >= self.y and mouseY <= self.y+self.closeSize then
        self.click()
        end
    else
        if mouseX >= self.x and mouseX <= self.x+self.width and mouseY >= self.y and mouseY <= self.y+self.height then
            print("Within bounds...")
            self.click()
        end
    end
end