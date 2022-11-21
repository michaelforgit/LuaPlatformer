local Class = require "assets/libraries/class"
local Menu = Class{}
require "uiobject"
function Menu:init()
    self.background = love.graphics.newImage('enemy.png')
end
function Menu:enter() -- runs every time the state is entered
    print("Entering menu state")
end

function Menu:update(dt) -- runs every frame

end
function Menu:draw()
    test = UIRectangle({love.graphics.getWidth()/2-love.graphics.getWidth()/8, 
    love.graphics.getHeight()-love.graphics.getHeight()/3.5, 
    love.graphics.getWidth()/4, 
    love.graphics.getHeight()/4, 
    35,
    "The quick brown fox jumped over the fence.  I do not know the rest this is just a test font."})
    test:draw()
    love.graphics.print("Press enter to continue", 100, 100)
end

function Menu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(levelOne)
    end
end

return Menu