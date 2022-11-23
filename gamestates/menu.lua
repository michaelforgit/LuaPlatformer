local Menu = {}
require("../entityList")
local entities = entityList()
local testing = entityList()
function Menu:new()
    self.background = love.graphics.newImage('enemy.png')
end
function Menu:enter() -- runs every time the state is entered
    love.graphics.setBackgroundColor(255/255, 51/255, 255/255)
    local test = UIButton(
        0+50,
        love.graphics.getHeight()/2+100,
        love.graphics.getWidth()/2-100, 
        50, 
        "blue",
        function() 
            Gamestate.switch(levelOne)
        end
    )
    test:setText("Play")
    test:setTextAlign("center")
    local test2 = UIButtonClosable(
        love.graphics.getWidth()/2+50,
        love.graphics.getHeight()/2+100,
        love.graphics.getWidth()/2-100, 
        150, 
        "red",
        function() 
            love.event.quit()
        end
    )
    test2:setText("Quit")
    test2:setTextAlign("center")
    local test3 = UIObject(
        love.graphics.getWidth()/2-250,
        50,
        500, 
        0, 
        "pink"
    )
    test3:setText("Welcome to the game!")
    test3:setTextAlign("center")
    entities:add(test)

    entities:add(test2)
    entities:add(test3)
end

function Menu:update(dt) -- runs every frame
    entities:update(dt)
end
function Menu:draw()
    entities:draw()
end

function Menu:resize()
    entities:clear()
    Gamestate.switch(Menu)

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
