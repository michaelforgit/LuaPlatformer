function love.load()
    
    Object = require "assets/libraries/classic";
    camera = require "assets/libraries/camera";
    listOfBullets = {};
    cam = camera();
    sti = require "assets/libraries/sti";
    gameMap = sti("assets/maps/map.lua");
    wf = require "assets/libraries/windfield";
    require "player";
    require "bullet";
    require "enemy";
    require "stack";
    require "uiobject";
    require "collidable";
    require "9slice";

    --testingBox = Slice(0, 0, 500, 500, 16, "assets/images/textbox2.png");
    world = wf.newWorld(0, 300, false);
    love.physics.setMeter(30);
    world:addCollisionClass("Platform");
    world:addCollisionClass("Player");
    world:addCollisionClass("Floor");
    world:addCollisionClass("Enemy");
    world:addCollisionClass("Bullet");
    love.window.setMode(800, 600, {resizable = true});
    love.graphics.setFont(love.graphics.newFont("assets/fonts/Abaddon Light.ttf", 20));

    player = Player();
    enemys = {};
    platforms = {};
    enemy = Enemy(120, 224.00);
    table.insert(enemys, enemy);
    guiStack = Stack();
    local test = {love.graphics.getWidth()/2-love.graphics.getWidth()/8, 
    love.graphics.getHeight()-love.graphics.getHeight()/3.5, 
    love.graphics.getWidth()/4, 
    love.graphics.getHeight()/4, 
    35,
    "The quick brown fox jumped over the fence.  I do not know the rest this is just a test font."}
    guiStack:push(UIRectangle(test));

    if gameMap.layers["floor"] then
        for i, obj in pairs(gameMap.layers["floor"].objects) do
            Floor:new(obj.x, obj.y, obj.width, obj.height);
        end
    end

    if gameMap.layers["platforms"] then
        for i, obj in pairs(gameMap.layers["platforms"].objects) do
            Platform:new(obj.x, obj.y, obj.width, obj.height);
        end
    end

    player.collider:setPreSolve(function(collider_1, collider_2, contact)
        if collider_1.collision_class == "Player" and collider_2.collision_class == "Platform" then
            c1EdgeH, c2EdgeH = collider_1:getY()+18, collider_2:getY()-collider_2:getObject().height/2;
            c1EdgeW, c2EdgeW = collider_1:getX()+9, collider_2:getX() + collider_2:getObject().width/2;
            if ((c1EdgeH > c2EdgeH) and (c1EdgeW > (c2EdgeW-collider_2:getObject().width)) and (c1EdgeW-collider_1:getObject().width/2 < c2EdgeW)) then  --add half of player and subtract half of object colliding.
                contact:setEnabled(false);
                player.jump = 1;
            end
        end
    end) 
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    for i,v in pairs(listOfBullets) do
        v:update(dt);
    end
    for i,v in pairs(enemys) do
        v:update(dt);
    end
    world:update(dt);
    player:update(dt);
    cam:zoomTo(4);
    cam:lookAt(player.x, player.y)
end

function love.draw()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["background"]);
        gameMap:drawLayer(gameMap.layers["misc"]);
        for i,v in pairs(listOfBullets) do
            if v.dead then
                v.collider:destroy();
                table.remove(listOfBullets, i);
            else
                v:draw();
            end
        end
        for i,v in pairs(enemys) do
            if v.health ~= 0 then
                v:draw();
            end
        end
        player:draw();
        world:draw();
    cam:detach()
    if guiStack:top() ~= nil then
        guiStack:top():draw();
    end

end

function love.resize()
    if guiStack:top() ~= nil then
        guiStack:top():resize();
    end
end
