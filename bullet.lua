Bullet = Object:extend(Object);

function Bullet:new(x, y, dir)
    self.image = love.graphics.newImage("assets/images/teamgunner/EXTRAS/bullet2.png");
    self.width = 10;
    self.height = 5;
    self.x = x-self.width/2;
    self.y = y;
    self.timer = 0;
    self.dead = false;
    if dir == 1 then
        self.collider = world:newBSGRectangleCollider(self.x+15, self.y+20, self.width, self.height, 5);  
    else
        self.collider = world:newBSGRectangleCollider(self.x-15, self.y+20, self.width, self.height, 5);  
    end
    self.collider:setCollisionClass("Bullet");
    self.collider:setLinearVelocity(1000*dir, 0);


    self.collider:setPostSolve(function(collider_1, collider_2, contact)            
        for i,v in pairs(listOfBullets) do
            if v == self then
                v.collider:destroy();
                table.remove(listOfBullets, i);
            end
        end
    end)
end
function Bullet:draw()
    love.graphics.rectangle("fill", self.collider:getX()-self.width/2, self.collider:getY()-self.height/2, self.width, self.height)
end

function Bullet:update(dt)
    self.x = self.collider:getX()-self.width/2;
    self.y = self.collider:getY()-self.height/2;
    self.timer = self.timer + dt;
    if self.timer >= 5 then
        self.dead = true;
    end
end