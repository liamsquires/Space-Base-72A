player = {}
healthBar = love.graphics.newImage('assets/battery.png')


function player:load(x,y)
    player.img = love.graphics.newImage('assets/roboson.png')
    player.x = player.startPointx or 400
    player.y = player.startPointy or 700
    player.w = 32
    player.h = 64
    player.speed = .6
    player.maxspeed = 7.5
    player.gravity = .5
    player.maxfallspeed = 15 -- HIGHEST POSSIBLE WITHOUT CLIPPING
    player.fuel = 100
    player.isonground = false
    player.jsmax = 13
    player.js = 0
    player.jsboost = .5
    player.xvel = 0
    player.onplatform=0
    player.id = 'player'
    player.maxhealth = 50
    -- jumpy boi
    player.onwall = false
    player.onwalldir = 'neutral'
    player.maxhealth = 50
    player.health = player.maxhealth
    player.dashVelocity = 24
    player.dashtimermax = 7
    player.dashtimer = player.dashtimermax
    player.dashCooldownMax = 50
    player.dashCooldown = player.dashCooldownMax
    player.middash = false
    -- Gun Related
    player.gunequipped = 'cannon' --singleshot cannon
    player.death = false
    player.returnbydeath = 0

end

function player:update(dt)
    --print(math.floor(player.x/32),math.floor(player.y/32))
    ContainPlayer()
    player.move(dt)
    px = math.floor(player.x/32)
    py = math.floor((player.y+32)/32)
    --print(player.onplatform)
    BulletCollide(player)
    if player.health <= 0 then --death
        player.death = true
        player.xvel =0
        player.js=0

        
        player.health = 50
         --dialogDoneForArea = false
         

        
    end
    

end


function player:move(dt)
--player.speed = 0.6

if player.dashCooldown > 0 then
    player.dashCooldown = player.dashCooldown - 1
end

if love.keyboard.isDown("lshift") and player.middash == false and player.dashCooldown <= 0 then 
    player.middash = true

end




if player.middash == true then
    player.dashtimer = player.dashtimer - 1
    player.xvel=math.cos(gun.angle)*player.dashVelocity
    player.js=math.sin(gun.angle)*-player.dashVelocity
    local test
    local testPoint = {}
        testPoint.x=player.x+player.xvel
        testPoint.y=player.y-player.js
         test = PlatformColide(testPoint,'dash')
        if test == true then
           player.xvel=math.cos(gun.angle)
           player.js =math.sin(gun.angle)*3
        end

    if player.dashtimer < 0 then
        player.dashtimer = player.dashtimermax
        player.middash = false
        player.xvel=player.maxspeed*math.cos(gun.angle)*2
        player.js=math.sin(gun.angle)*-7
        player.dashCooldown = player.dashCooldownMax
        if test == true then
           player.xvel=0
           player.js =0
        end
    end
end

if love.keyboard.isDown("a") and player.middash == false then
    if player.xvel - player.speed > 0-player.maxspeed then
    if player.xvel > 0 then
        player.xvel = player.xvel - player.speed*2
    else 
        player.xvel = player.xvel - player.speed
        end
    end
end

if love.keyboard.isDown("d") and player.middash == false then
    if (player.xvel + player.speed < player.maxspeed) then

            if player.xvel < 0 then
                player.xvel = player.xvel + player.speed*3
            else
            player.xvel = player.xvel + player.speed
        end
        end
end
if player.isonground == true or player.onwall == true then
    if love.keyboard.isDown("w") or love.keyboard.isDown("space") then
        if player.onwall == true then
            if player.onwalldir == 'left' then
                player.xvel = 5
            else
                player.xvel = -5
            end
        end
            player.isonground = false
            player.onwall = false
            player.js = player.jsmax
    end
end

if player.isonground == false then
    if player.onwall == false and player.middash == false then
        player.js = player.js - player.gravity
    else
        player.js = player.js - player.gravity/2
    end
else
    if player.onwall == true then
    player.js = 0
    end
    if player.isonground == true then
        
    if player.onplatform == 0 then
        if player.xvel > 0 then
            if player.xvel - 0.2 < 0 then
                player.xvel = 0
            else
                player.xvel = player.xvel - 0.2
            end
        else
            if player.xvel + 0.2 > 0 then
                player.xvel = 0
            else
                player.xvel = player.xvel + 0.2
            end
        end
    else
        if player.xvel > 0 then
            if player.xvel - platforms[player.onplatform-1].friction < 0 then
                player.xvel = 0
            else
                player.xvel = player.xvel - platforms[player.onplatform-1].friction
            end
        else
            if player.xvel + platforms[player.onplatform-1].friction > 0 then
                player.xvel = 0
            else
                player.xvel = player.xvel + platforms[player.onplatform-1].friction
            end
        end
        
    end
    end
end



 if player.isonground == false then
        if love.keyboard.isDown("s") then         --Magnet boots. Cause you to clip through the floor and get thrown left
            player.gravity = 3
        end
    end

    if player.isonground == true then
        player.gravity = .5
    end

if player.js < -player.maxfallspeed and player.middash == false  and player.dashCooldown<(player.dashCooldownMax-8) then
    player.js = -player.maxfallspeed

end
player.y = player.y - player.js
player.x = player.x + player.xvel
end



function ContainPlayer()
    if player.x < westWall then -- Hit lefts Wall
        player.x = westWall
    end
    if player.x + player.w > eastWall then -- Hits Right Wall
        player.x = eastWall - player.w
    end
    if player.y < northWall then -- Hit Roof
        player.y = northWall
        player.js = 0
    end
    if player.y + player.h > southWall then --Hit Floor
       player.y = southWall - player.h
       print('HIT',player.y)
        player.isonground = true
        player.onwall = false
        player.onplatform = 0
    end
end

function drawPlayer()
    love.graphics.setColor(255,255,255)
    if gun.angle > 1.5 then
        gun.draw()
        love.graphics.draw(player.img,player.x,player.y,0,-1,1,player.w,0) -- Rotation,SX,SY,OX,OY
    end 
    if gun.angle < 1.5 then
        love.graphics.draw(player.img,player.x,player.y)
        gun.draw()
    end

    love.graphics.setColor(97/255,95/255,95/255)
    love.graphics.rectangle('fill',camera.xisGonnaBe+32,camera.yisGonnaBe+37,64,123)
    love.graphics.setColor(HealthColoring())
    love.graphics.rectangle('fill',camera.xisGonnaBe+32,camera.yisGonnaBe+healthBar:getHeight()+32,64,HealthHeight())
    love.graphics.setColor(255,255,255)
    
    
    love.graphics.draw(healthBar, camera.xisGonnaBe+32,camera.yisGonnaBe+32)
end

function HealthColoring()
    local r
    local g
    local b
    if player.health > player.maxhealth/3 then
        if player.health > (player.maxhealth/3)*2 then
        r = 13
        g = 223
        b = 121
        else
        r = 223
        g = 159
        b = 13
        end
    else
        r = 255
        g = 0
        b = 0
    end
    return (r/255),(g/255),(b/255)
end

function HealthHeight()
-- height of image = 120
local height = 120
local percent = player.health / player.maxhealth
return -(height*percent)


end