entityList = Object:extend()

function entityList:new()
    self.entities = {}
end

function entityList:add(obj)
    table.insert(self.entities, obj)
end

function entityList:remove(entity)
    for i, v in ipairs(self.entities) do
        if v == entity then
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
        if v.remove then
            table.remove(self.entities, i)
        end
        v:update(dt)
    end
end

function entityList:mousepressed(x, y, button)
    for i, v in ipairs(self.entities) do
        if v:is(UIButton) then
            v:mousepressed(x, y, button)
        end
    end
end

function entityList:clear()
    self.entities = {}
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
