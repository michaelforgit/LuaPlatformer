local Class = require "assets/libraries/class"
local Collidable = Class{}

function Collidable:init(x, y, width, height)
    self.x = x;
    self.y = y;
    self.width = width;
    self.height = height;
    self.collider = world:newRectangleCollider(x, y, width, height);
    self.collider:setType("static");
    self.collider:setObject(self);
end

Platform = Class{
    __includes = Collidable
}

function Platform:init(x, y, width, height)
    Collidable.init(self, x, y, width, height);
    self.collider:setCollisionClass("Platform");
end

Floor = Class{
    __includes = Collidable
}

function Floor:init(x, y, width, height)
    Collidable.init(self, x, y, width, height);
    self.collider:setCollisionClass("Floor");
end


