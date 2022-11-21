local Class = require "assets/libraries/class"

local Stack = Class{};

local stackArr = {}; 

function Stack:init()
    self.stackArr = {}
end

function Stack:push(obj)
    table.insert(self.stackArr, obj)
end

function Stack:pop()
    table.remove(self.stackArr, #self.stackArr);
end

function Stack:top() 
    return (self.stackArr[#self.stackArr]);
end
