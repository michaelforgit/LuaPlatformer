Collidable = Object.extend(Object);

function Collidable:new(x, y, width, height)
    self.x = x;
    self.y = y;
    self.width = width;
    self.height = height;
    self.collider = world:newRectangleCollider(x, y, width, height);
    self.collider:setType("static");
    self.collider:setObject(self);
end

Platform = Collidable:extend()

function Platform:new(x, y, width, height)
    Platform.super.new(self, x, y, width, height);
    self.collider:setCollisionClass("Platform");
end

Floor = Collidable:extend()

function Floor:new(x, y, width, height)
    Floor.super.new(self, x, y, width, height);
    self.collider:setCollisionClass("Floor");
end


