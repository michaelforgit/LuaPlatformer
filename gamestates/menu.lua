local Menu = {}
require("../entityList")
local entities = entityList()
local testing = entityList()
function Menu:new()

end
function Menu:enter() -- runs every time the state is entered
    love.graphics.setBackgroundColor(255/255, 51/255, 255/255)
    -- local test = UIButton(
    --     0+50,
    --     0,
    --     love.graphics.getHeight()/2+100,
    --     0,
    --     love.graphics.getWidth()/2-100,
    --     0, 
    --     50, 
    --     0,
    --     function() 
    --         Gamestate.switch(levelOne)
    --     end
    -- )
    -- test:setText("Play")
    -- test:setTextAlign("center")
    -- test:setColor("blue")
    -- local test2 = UIButtonClosable(
    --     love.graphics.getWidth()/2+50,
    --     0,
    --     love.graphics.getHeight()/2+100,
    --     0,
    --     love.graphics.getWidth()/2-100,
    --     0, 
    --     150,
    --     0, 
    --     function() 
    --         love.event.quit()
    --     end
    -- )
    -- test2:setText("Quit")
    -- test2:setTextAlign("center")
    -- test2:setColor("red")
    local div
    if (love.graphics.getWidth() >= 1280) and (love.graphics.getHeight() >= 720) then
        div = UIObject(
            1/2,
            -640,
            1/2,
            -360,
            0,
            1280, 
            0, 
            720
        )
    else 
        div = UIObject(
            0,
            0,
            0,
            0,
            0,
            love.graphics.getWidth(), 
            0, 
            love.graphics.getHeight()
        )
    end
    local quitButton = UIButton(
        5/8,
        0,
        1-1/8,
        -100,
        1/4,
        0, 
        0, 
        75,
        function() 
            love.event.quit()
        end
    )
    local playButton = UIButton(
        1/8,
        0,
        1-1/8,
        -100,
        1/4,
        0, 
        0, 
        75,
        function() 
            Gamestate.switch(levelOne)
        end
    )
    local title = UIObject(
        0,
        0,
        0,
        0,
        1,
        0, 
        1/2, 
        -150
    )
    local playerSelect = UIObject(
        1/2,
        -87.5,
        1/2,
        -150,
        0,
        175, 
        0, 
        250
    )
    entities:add(div)
    playButton:setText("Play", "center")
    playButton:setColor("blue")
    playButton:setParent(div)
    quitButton:setText("Quit", "center")
    quitButton:setColor("red")
    quitButton:setParent(div)
    playerSelect:setColor("green")
    playerSelect:setImage(love.graphics.newImage("assets/images/teamgunner/CHARACTER_SPRITES/Black/Gunner_Black.png"))
    playerSelect:setParent(div)
    title:setText("LOVE2D Platformer", "center")
    title:setParent(div)
    entities:add(title)
    entities:add(playerSelect)
    entities:add(playButton)
    entities:add(quitButton)
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
