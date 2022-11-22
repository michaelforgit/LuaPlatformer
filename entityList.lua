entityList = Object:extend()

function entityList:new()
    print("I SHOULD BE IN NEW")
    self.entities = {}
end

function entityList:add(obj)
    table.insert(self.entities, obj)
    print(self.entities[1])
end

function entityList:remove(obj)
    table.remove(self.entities, obj)
end

function entityList:top()
    return (self.entities[#self.entities])
end

function entityList:draw()
    for i, v in ipairs(self.entities) do
        v:draw(i)
    end
end

function entityList:update(dt)
    for i, v in ipairs(self.entities) do
        v:update(dt)
    end
end

function entityList:clear()
    self.entityList = {}
end

function entityList:count()
    return #self.entities
end

function entityList:print()
    for i,v in pairs(self.entities) do
        print(v)
    end
end
