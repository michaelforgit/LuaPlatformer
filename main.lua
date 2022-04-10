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
    love.physics.setMeter(10);
    world = wf.newWorld(0, 300, false);
    world:addCollisionClass("Platform");
    world:addCollisionClass("Player");
    world:addCollisionClass("Floor");
    world:addCollisionClass("Enemy");
    world:addCollisionClass("Bullet");
    love.window.setMode(800, 600, {resizable = true});

    font = love.graphics.newFont("assets/fonts/Abaddon Light.ttf", 20);
    love.graphics.setFont(font);

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
            local floor = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height);
            floor:setType("static");
            floor:setCollisionClass("Floor")
            table.insert(platforms, floor)
        end
    end

    if gameMap.layers["platforms"] then
        for i, obj in pairs(gameMap.layers["platforms"].objects) do
            local platform = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height);
            platform:setType("static");
            platform:setCollisionClass("Platform")
            table.insert(platforms, platform)
        end
    end

    player.collider:setPreSolve(function(collider_1, collider_2, contact)
        if collider_1.collision_class == "Player" and collider_2.collision_class == "Platform" then
            if (collider_1:getY() > collider_2:getY()) then
                contact:setEnabled(false);
                player.jump = 1;
                --print(player.collider:getPosition());
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

    --[[SCRAP CODE]]
    --[[world:setCallbacks(
        function(collider_1, collider_2, contact) 
            print("HERE");
            print(collider_1:getBody():getY());
            --if collider_1.collision_class == "Player" and collider_2.collision_class == "Platform" then
                if (collider_1:getBody():getY() > collider_2:getBody():getY()) then
                    contact:setEnabled(false);
                    --print(player.collider:getPosition());
                else
                    player.jump = 0;
                end
            --end
        end, 
    function() 
        
    end, 
    function()
    
    end
    --[[function(collider_1, collider_2, contact) 
        print("HERE");
        print(collider_1:getBody():getY());
        --if collider_1.collision_class == "Player" and collider_2.collision_class == "Platform" then
            if (collider_1:getBody():getY() > collider_2:getBody():getY()) then
                contact:setEnabled(false);
                --print(player.collider:getPosition());
            else
                player.jump = 0;
            end
        --end
    end, 
    function() 
         
    end)]]

        --[[enemy.collider:setPostSolve(function(collider_1, collider_2, contact)
        if collider_1.collision_class == "Enemy" and collider_2.collision_class == "Bullet" then
            enemy.health = enemy.health - 5;
            print(enemy.health);
            for i,v in pairs(listOfBullets) do
                if v.collider == collider_2 then
                    v.collider:destroy();
                    table.remove(listOfBullets, i);
                end
            end
            if enemy.health == 0 then
                for i,v in pairs(enemys) do
                    if v == enemy then
                        table.remove(enemys, i);
                        print("HERE");
                    end
                end
                enemy.collider:destroy();
            end
        end
    end)]]