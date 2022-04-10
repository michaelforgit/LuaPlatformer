UIObject = Object.extend(Object);

function UIObject:new(specs)
    self.x = specs[1];
    self.y = specs[2];
    self.width = specs[3];
    self.height = specs[4];
    self.closeSize = specs[5];  --Set to 0 if you do not want a close option.
    self.text = specs[6];
end

function UIObject:draw()
    love.graphics.setColor(1, 1, 1);
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height);
    love.graphics.setColor(0, 0, 0);
    love.graphics.printf(self.text, self.x+20, self.y+20, self.width-40, "left");
end

function UIObject:update()

end

UIRectangle = UIObject:extend()

function UIRectangle:new(specs)
    UIRectangle.super.new(self, specs);
end

function UIRectangle:draw()
    UIRectangle.super.draw(self);
    if self.closeSize > 0 then
        love.graphics.setColor(255/255, 0, 0);
        love.graphics.rectangle("fill", self.x+self.width-self.closeSize, self.y, self.closeSize, self.closeSize);
        love.graphics.setColor(0, 0, 0);
        love.graphics.printf("X", self.x+self.width-self.closeSize, self.y+love.graphics.getFont():getHeight()/2, self.closeSize, "center");
        function love.mousepressed(mouseX, mouseY, button, isTouch, presses)
            if mouseX >= self.x+self.width-self.closeSize and mouseX <=self.x+self.width and mouseY >= self.y and mouseY <= self.y+self.closeSize then
               guiStack:pop();
            end
        end
        love.graphics.setColor(1, 1, 1);
    end
end




