local Menu = {}
require("../entityList")
local entities = entityList()
local testing = entityList()
function Menu:new()
    self.background = love.graphics.newImage('enemy.png')
end
function Menu:enter() -- runs every time the state is entered
    testing:add("Hello")
    print(testing:top())
    testing:add("World")
    print(testing:top())
    print(testing:count())
    local test = UIObject(
        0+50,
        love.graphics.getHeight()/2+100,
        love.graphics.getWidth()/2-100, 
        50, 
        0,
        "Click here to enter the game",
        "blue",
        function() 
            Gamestate.switch(levelOne)
        end
    )

    local test2 = UIObject(
        love.graphics.getWidth()/2+50,
        love.graphics.getHeight()/2+100,
        love.graphics.getWidth()/2-100, 
        50, 
        0,
        "Click here to quit the game",
        "red",
        function() 
            love.event.quit()
        end
    )
    entities:add(test)

    entities:add(test2)
end

function Menu:update(dt) -- runs every frame
    entities:update(dt)
end
function Menu:draw()
    entities:draw()
end

function Menu:resize()
    entities:resize()
end

function Menu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(levelOne)
    end
end

function Menu:mousepressed(x, y, button)
    entities:mousepressed(x, y, button)
end

return Menu

--Example of how to remove self from entities
--entities:removeSelf(test)
