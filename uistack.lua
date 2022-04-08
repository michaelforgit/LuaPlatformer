UiStack = Object.extend(Object);

local stack = {}; 

function UiStack:new()
    self.stack = {}
end

function UiStack:push(obj)
    table.insert(self.stack, obj)
end

function UiStack:pop()
    table.remove(self.stack, #self.stack);
end

function UiStack:top() 
    return (self.stack[#self.stack]);
end
