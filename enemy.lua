Enemy = Object.extend(Object);

function Enemy:new(x, y)
    self.health = 100;
    self.jump = 0;
    self.speed = 150;
    self.height = 35;
    self.width = 24;
    self.x = x;
    self.y = y-self.height;
    self.direction = 1;
    self.collider = world:newRectangleCollider(self.x, self.y, self.width, self.height)
    self.collider:setCollisionClass("Enemy");
    self.collider:setFixedRotation(true);
    --self.collider:setType("static");
    self.image = love.graphics.newImage("enemy.png")

    self.collider:setPreSolve(function(collider_1, collider_2, contact)
        if collider_2.collision_class == "Bullet" then
            contact:setEnabled(false);
            self.health = self.health - 5;
            --print(self.collider:getX())
            if self.health == 0 then
                self.collider:destroy();
                for i,v in pairs(enemys) do
                    if v == self then
                        table.remove(enemys, i);
                    end
                end
            end
        end
    end)
end
function Enemy:move(xSpeed, ySpeed)
    --vx, vy = self.collider:getLinearVelocity();  --[[Throw away useless first return value]]
    self.collider:setLinearVelocity(xSpeed, ySpeed);
    --print(self.collider:getX())
end

--[[function Enemy:moveUntil(xSpeed, ySpeed, x, y)  --left off here
    x = x + self.collider:getX();
    y = y + self.collider:getY();
    test = 0;
    while (self.collider:getX() < x) and (test <= 5) do
        self:move(xSpeed, ySpeed)
        test = test + 1
        print (self.collider:getX())
    end
end]]--



function Enemy:draw()
    love.graphics.setColor(1, 0, 0);
    love.graphics.rectangle("fill", self.x, self.y-2.5, self.width, 2.5);
    love.graphics.setColor(0, 128/255, 0);
    love.graphics.rectangle("fill", self.x, self.y-2.5, self.width-(((100-self.health)/100)*self.width), 2.5);
    love.graphics.setColor(1, 1, 1);
    love.graphics.draw(self.image, self.collider:getX()-self.width/2, self.collider:getY()-self.height/2, 0, self.width/self.image:getWidth(), self.height/self.image:getHeight());
end

function Enemy:update(dt)

    if self.collider:enter('Bullet') then
        while(self.collider:getX() < 150) do
            self:move(20, 0)
            print(self.collider:getX())
        end
    end
    self.x = self.collider:getX()-self.width/2;
    self.y = self.collider:getY()-self.height/2;
end



