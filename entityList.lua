entityList = Object:extend()

function entityList:new()
    self.entities = {}
end

function entityList:add(obj)
    table.insert(self.entities, obj)
    print(self:count())
end

function entityList:removeSelf(entity)
    print("in remove self")
    for i, v in ipairs(self.entities) do
        if v == entity then
            print("SHOULD BE REMOVING")
            table.remove(self.entities, i)
        end
    end
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

function entityList:mousepressed(x, y, button)
    for i, v in ipairs(self.entities) do
        v:mousepressed(x, y, button)
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

function entityList:resize()
    for i, v in ipairs(self.entities) do
        v:resize()
    end
end
