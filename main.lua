function love.load()
    Gamestate = require "assets/libraries/gamestate"    
    Object = require "assets/libraries/classic"
    Menu = require "gamestates/menu" -- previously: Gamestate.new()
    levelOne = require "gamestates/levelOne"
    camera = require "assets/libraries/camera"
    listOfBullets = {}
    cam = camera()
    sti = require "assets/libraries/sti"
    gameMap = sti("assets/maps/map.lua")
    wf = require "assets/libraries/windfield"
    require "player"
    require "bullet"
    require "enemy"
    require "stack"
    require "uiobject"
    require "collidable"
    require "9slice"
    love.profiler = require('profile') 
    love.profiler.start()
    Gamestate.registerEvents() -- calls love.update, love.draw
    Gamestate.switch(Menu)
    love.graphics.setFont(love.graphics.newFont("assets/fonts/Abaddon Light.ttf", 20))
end
love.frame = 0
function love.update(dt)
    -- love.frame = love.frame + 1
    -- if love.frame%100 == 0 then
    --     love.report = love.profiler.report(20)
    --     love.profiler.reset()
    -- end
end

function love.draw()
    -- love.graphics.print(love.report or "Please wait...")
end

function love.resize()

end
