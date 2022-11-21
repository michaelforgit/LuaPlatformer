local Class = require "assets/libraries/class"
local UIObject = require "uiobject"
local Menu = Class{}
local states = {first, second, third}
function Menu:init()
    test = UIObject(
        love.graphics.getWidth()-love.graphics.getWidth()/2, 
        love.graphics.getHeight()/4, 
        love.graphics.getWidth()/2, 
        love.graphics.getHeight()/2, 
        0,
        true,
        "Click here to enter the game",
        function() 
            print("Hello World") 
        end
    )
    -- test2 = UIObject(
    --     0, 
    --     love.graphics.getHeight()/4, 
    --     love.graphics.getWidth()/2, 
    --     love.graphics.getHeight()/2, 
    --     0,
    --     true,
    --     "Click here to bye world",
    --     function() 
    --         print("Bye world") 
    --     end
    -- )
end
function Menu:enter() -- runs every time the state is entered
    print("Entering menu state")
end

function Menu:update(dt) -- runs every frame

end
function Menu:draw()
    test:draw()
    -- test2:draw()
end

function Menu:keyreleased(key, code)
    
end

return Menu