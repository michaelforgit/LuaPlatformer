Gamestate = require "assets/libraries/gamestate"

local levelOne = {}

function levelOne:enter()
    --testingBox = Slice(0, 0, 500, 500, 16, "assets/images/textbox2.png")
    world = wf.newWorld(0, 700, false)
    love.physics.setMeter(30)
    world:addCollisionClass("Platform")
    world:addCollisionClass("Player")
    world:addCollisionClass("Floor")
    world:addCollisionClass("Enemy")
    world:addCollisionClass("Bullet")
    player = Player()
    enemys = {}
    platforms = {}
    enemy = Enemy(120, 224.00)
    table.insert(enemys, enemy)
    if gameMap.layers["floor"] then
        for i, obj in pairs(gameMap.layers["floor"].objects) do
            Floor(obj.x, obj.y, obj.width, obj.height)
        end
    end

    if gameMap.layers["platforms"] then
        for i, obj in pairs(gameMap.layers["platforms"].objects) do
            Platform(obj.x, obj.y, obj.width, obj.height)
        end
    end

    player.collider:setPreSolve(function(collider_1, collider_2, contact)
        if collider_1.collision_class == "Player" and collider_2.collision_class == "Platform" then
            c1EdgeH, c2EdgeH = collider_1:getY()+18, collider_2:getY()-collider_2:getObject().height/2
            c1EdgeW, c2EdgeW = collider_1:getX()+9, collider_2:getX() + collider_2:getObject().width/2
            if ((c1EdgeH > c2EdgeH) and (c1EdgeW > (c2EdgeW-collider_2:getObject().width)) and (c1EdgeW-collider_1:getObject().width/2 < c2EdgeW)) then  --add half of player and subtract half of object colliding.
                contact:setEnabled(false)
            end
            if (c2EdgeH < c1EdgeH) then
                print("hello")
                contact:setEnabled(false)
            end
        end
    end) 
end
function levelOne:update(dt)
    for i,v in pairs(listOfBullets) do
        v:update(dt)
    end
    for i,v in pairs(enemys) do
        v:update(dt)
    end
    world:update(dt)
    player:update(dt)
    cam:zoomTo(4)
    cam:lookAt(player.x, player.y)
end
function levelOne:draw()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["background"])
        gameMap:drawLayer(gameMap.layers["misc"])
        for i,v in pairs(listOfBullets) do
            if v.dead then
                v.collider:destroy()
                table.remove(listOfBullets, i)
            else
                v:draw()
            end
        end
        for i,v in pairs(enemys) do
            if v.health ~= 0 then
                v:draw()
            end
        end
        player:draw()
        world:draw()
    cam:detach()
end

return levelOne