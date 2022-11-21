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

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(levelOne)
    love.window.setMode(800, 600, {resizable = true})
    love.graphics.setFont(love.graphics.newFont("assets/fonts/Abaddon Light.ttf", 20))
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function love.draw()

end

function love.resize()

end
