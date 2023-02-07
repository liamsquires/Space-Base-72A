
enemies = {}
require"breakables"

mari = love.graphics.newImage('assets/boi.png')
bulb = love.graphics.newImage('assets/bulb.png')
bulbtop = love.graphics.newImage('assets/bulbtop.png')
floater = love.graphics.newImage('assets/floater.png')
naofumi = love.graphics.newImage('assets/devilofshield.png')
theKing = love.graphics.newImage('assets/longLiveTheKing.png')

function createEnemy(x,y,enemyType, rotation)
    newEnemy = {
     enemyType = enemyType,
     x = x*32,
     y = y*32,
     isonground = false,
     onplatform = 0,
     rotation = rotation or 0,
     distanceToPlayer = 0,
     anglex = 0,
     angley = 0,
     angle = 0,

    }
    if  enemyType== 1 then
       
        
        newEnemy.img = mari
        newEnemy.health = 20
        newEnemy.id = 'enemy'
        newEnemy.gravity = .3
        newEnemy.jsmax = 8
        newEnemy.js = 0
        newEnemy.xvel = 0
        newEnemy.speed = .3
        newEnemy.maxspeed = 2
        newEnemy.gridx = x
        newEnemy.gridy = y
        newEnemy.htox = x
        newEnemy.htoy = y
        newEnemy.maxjumpcell = 4
        newEnemy.going = 'left'
        newEnemy.maxleftcell = 0
        newEnemy.maxrightcell = 0
        newEnemy.damage=6
        newEnemy.hitCooldownMax = 20
        newEnemy.hitCooldown = newEnemy.hitCooldownMax
        newEnemy.isCharging = false
        newEnemy.firerate = 20
        newEnemy.cooldown = newEnemy.firerate
    end
    if enemyType ==2 then
        newEnemy.img = bulb
        newEnemy.health = 20
        newEnemy.id = 'enemy'
        newEnemy.gravity = 0
        newEnemy.jsmax = 0
        newEnemy.js = 0
        newEnemy.xvel = 0
        newEnemy.speed = 0
        newEnemy.maxspeed = 0
        newEnemy.firerate = 8
        newEnemy.cooldown = newEnemy.firerate
        newEnemy.rotation = newEnemy.rotation*1/2*math.pi
        
    end
    if enemyType ==3 then
        newEnemy.img = floater
        newEnemy.health = 10
        newEnemy.id = 'enemy'
        newEnemy.gravity = 0
        newEnemy.jsmax = 8
        newEnemy.js = 0
        newEnemy.xvel = 0
        newEnemy.speed = 0.3
        newEnemy.maxspeed = 4
        newEnemy.cooldown = newEnemy.firerate
        newEnemy.gridx = x
        newEnemy.gridy = y
        newEnemy.htox = x
        newEnemy.htoy = y
        newEnemy.damage = 5
        newEnemy.hitCooldownMax = 20
        newEnemy.hitCooldown = newEnemy.hitCooldownMax

    end

    if  enemyType== 4 then
        newEnemy.img = naofumi
        newEnemy.health = 20
        newEnemy.id = 'enemy'
        newEnemy.gravity = .3
        newEnemy.jsmax = 8
        newEnemy.js = 0
        newEnemy.xvel = 0
        newEnemy.speed = .3
        newEnemy.maxspeed = 1
        newEnemy.gridx = x
        newEnemy.gridy = y
        newEnemy.htox = x
        newEnemy.htoy = y
        newEnemy.maxjumpcell = 4
        newEnemy.going = 'left'
        newEnemy.maxleftcell = 0
        newEnemy.maxrightcell = 0
        newEnemy.damage=6
        newEnemy.hitCooldownMax = 10
        newEnemy.hitCooldown = newEnemy.hitCooldownMax
        newEnemy.isCharging = false
        newEnemy.hasFC = false
        newEnemy.ChargeDuration = 10
        newEnemy.ChargeDurationMax = 10
        newEnemy.chargeCooldownMax = 20
        newEnemy.chargeCooldown = newEnemy.chargeCooldownMax
        newEnemy.hasShield = true
        newEnemy.onplatform = -32
        NewBreakable(x*32,(y-1)*32)
        
        newEnemy.shieldID = #breakables
    end

            if enemyType == 'the king' then
            newEnemy.img = theKing
            newEnemy.health = 225
            newEnemy.x = newEnemy.x/32
            newEnemy.y = newEnemy.y/32
            newEnemy.id = 'enemy'
            newEnemy.isCharging = false
              newEnemy.gravity = 0
        newEnemy.jsmax = 0
        newEnemy.js = 0
        newEnemy.xvel = 0
        newEnemy.speed = 0
        newEnemy.maxspeed = 0
        end

    newEnemy.w = newEnemy.img:getWidth()
    newEnemy.h = newEnemy.img:getHeight()
    table.insert(enemies,newEnemy)
end


function drawEnemies() 
    for i, e in ipairs(enemies) do
        --print(e.rotation)
        if e.enemyType == 1 or e.enemyType == 4 or e.enemyType == 3 then
            if e.going == 'left' or e.xvel<0 then
                love.graphics.draw(e.img,e.x,e.y)
            else
                love.graphics.draw(e.img,e.x,e.y,0,-1,1,e.w,0)
            end

        end

        if e.enemyType == 2 then -- Enemy 2 i aint bothering with this lmao
            if e.rotation == 0 then
                if math.deg(e.angle) > 0 and math.deg(e.angle) < 90 then
                    e.angle = math.rad(5)
                end
                
                if math.deg(e.angle) > 90 and math.deg(e.angle) < 180 then
                    e.angle = math.rad(175)
                end
                love.graphics.draw(bulbtop,e.x+16,e.y+16,e.angle+math.pi/2,1,1,16,16)
                love.graphics.draw(e.img,e.x,e.y)
                
            elseif e.rotation == math.pi/2 then
                if e.angle > math.pi/6 then
                    e.angle = math.pi/6
                end
                if e.angle < math.pi/-6 then
                    e.angle = math.pi/-6
                end
                love.graphics.push()
                --love.graphics.translate(32,0)
                love.graphics.draw(e.img,e.x+32,e.y,math.pi/2,1,1)
                love.graphics.draw(bulbtop,e.x+16,e.y+16,e.angle+math.pi/2,1,1,16,16)
                love.graphics.pop()
            elseif e.rotation == math.pi then
                if e.angle > math.pi/6+math.pi/2 then
                    e.angle = math.pi/6+math.pi/2
                end
                if e.angle < math.pi/-6+math.pi/2 then
                    e.angle = math.pi/-6+math.pi/2
                end
                love.graphics.push()
                --love.graphics.translate(32,32)
                love.graphics.draw(bulbtop,e.x+16,e.y+16,e.angle+math.pi/2,1,1,16,16)
                love.graphics.draw(e.img,e.x,e.y+32,0,1,-1)

                love.graphics.pop()
            elseif e.rotation == math.pi*3/2 then
                if e.angle > math.pi/6+math.pi then
                    e.angle = math.pi/6+math.pi
                end
                if e.angle < math.pi/-6+math.pi then
                    e.angle = math.pi/-6+math.pi
                end
                love.graphics.push()
                --love.graphics.translate(0,32)
                love.graphics.draw(e.img,e.x,e.y,-math.pi/2,-1,1)
                love.graphics.draw(bulbtop,e.x+16,e.y+16,e.angle+math.pi/2,1,1,16,16)
                love.graphics.pop()
            end
        end
               if e.enemyType == 'the king' and e.health > 0 then
                love.graphics.draw(e.img,e.x,e.y)
            end
    end
end

function angleToPlayer(e)
    e.anglex = player.x - e.x 
    e.angley = player.y - e.y 
    e.angle = math.atan(e.angley/e.anglex)
    if e.anglex < 0 then
        e.angle = e.angle + math.pi
    end
    e.distanceToPlayer = math.sqrt(e.anglex^2 + e.angley^2)
end

function EnemySeePlayer(e)
    angleToPlayer(e)
    local diry = math.sin(e.angle)
    local dirx = math.cos(e.angle)
    local test
    local testPoint = {}
    for i=0,e.distanceToPlayer/32 do 
        
        testPoint.x=e.x+dirx*i*32
        testPoint.y=e.y+diry*i*32
         test = PlatformColide(testPoint)
        if test == true then
           return false
        end
    end
    return true
end

function EnemyPathfind()

end

function EnemyJump(e) -- Enemy with JSmax = 8 == 4 tiles up
    e.isonground = false
    e.js = e.jsmax
end

function EnemyShoot(e)
    if e.cooldown < 0 then
        local enemyfiresatthisangle = math.rad(math.deg(e.angle) - math.random(-10,10))
        --local accuracy = love.math.random()/3
        --local tempangle = e.angle + accuracy
        
        if e.enemyType == 1 then
            enemyfiresatthisangle = math.rad(math.deg(e.angle) - math.random(-2,2))
        end
        bullet:create(enemyfiresatthisangle, e, 4)
        e.cooldown = e.firerate
    end

end

function updateEnemies()
    --EnemyPathfind()
   local THELEVEL = progression[currentlvl]
   local mapw = THELEVEL[#THELEVEL - 1]
   local maph = THELEVEL[#THELEVEL]

    if stageOrder[stageIndex][currentlvl] == bossRoom and theBossWasMade == false then
            createBoss()
            theBossWasMade = true
    end

    for i, e in ipairs(enemies) do
          if e.enemyType == 'the king' then
                        angleToPlayer(e)
                        bossAttack(e)
                    end
        
         if e.enemyType == 2 or e.enemyType == 1 then -- Extremely Grounded Child
            if e.cooldown > 0 then
            e.cooldown = e.cooldown - .3
            end
            if EnemySeePlayer(e) == true then
            EnemyShoot(e)
            end
        end
        if e.enemyType ==3 then -- Flying Child
                if enemyHitPlayer(e,player) and e.hitCooldown ==0 then
                    player.health=player.health-e.damage
                    e.hitCooldown=e.hitCooldownMax
                end
              if e.x < player.x then
                  e.xvel = e.xvel+e.speed
              end
              if e.x > player.x then
                  e.xvel = e.xvel-e.speed
              end
              if e.y < player.y then
                  e.js = e.js-e.speed
              end
              if e.y > player.y then
                  e.js = e.js+e.speed
              end
              if e.hitCooldown > 0 then
                  e.hitCooldown = e.hitCooldown - 1
              end
        end

            if e.enemyType == 1 or e.enemyType == 4 then
                e.hy = (e.h/32) - 1
                e.wx = (e.w/32) - 1
                for b = 0, mapw-2 do --Checks Left
                    if THELEVEL[e.gridx-b+((e.gridy+1+e.hy)*mapw)] == 0 or THELEVEL[e.gridx-b+((e.gridy+e.hy)*mapw)] == 1 or THELEVEL[e.gridx-b+((e.gridy+e.hy)*mapw)] == 2 or THELEVEL[e.gridx-b+((e.gridy+e.hy)*mapw)] == 3 then
                        e.maxleftcell = b
                        break
                    end
                end
                for b = 0, mapw-2 do --Checks Right
                    if THELEVEL[e.gridx+e.wx+b+((e.gridy+1+e.hy)*mapw)] == 0 or THELEVEL[e.gridx+e.wx+b+((e.gridy+e.hy)*mapw)] == 1 or THELEVEL[e.gridx+e.wx+b+((e.gridy+e.hy)*mapw)] == 2 or THELEVEL[e.gridx+e.wx+b+((e.gridy+e.hy)*mapw)] == 3 then
                        if b > 1 then
                            e.maxrightcell = b-2
                        else
                            e.maxrightcell = b+2
                        end
                        break
                    end
                end
                if e.enemyType ==1 or e.enemyType == 4 then -- Grounded Child
                    
                    CheckIfPlayer(e)
                    if e.maxleftcell == 0 and e.isCharging == false then
                        e.going = 'right'
                       -- print('is on platform id : '..e.onplatform)
                    end
                    if e.maxrightcell == 0 and e.isCharging == false then
                        e.going = 'left'
                    end

                    if e.going == 'left' then
                        e.xvel = e.xvel-e.speed
                    end
                    if e.going == 'right' then
                        e.xvel = e.xvel + e.speed
                    end

                    if e.x < westWall then
                        e.x = westWall
                        e.going = 'right'
                        e.isCharging = false
                        e.hasFC = true
                    end
                    if e.x+e.w > eastWall then
                        e.x = eastWall - e.w
                        e.going = 'left'
                        e.isCharging = false
                        e.hasFC = true
                    end

                    
                end

            


                if e.enemyType == 4 then
                if e.hasShield == true then
                    if breakables[e.shieldID] ~= nil and breakables[e.shieldID].hits < 0 then
                        e.hasShield = false
                        breakables[e.shieldID] = nil
                        
                    end
                end
                    ---debug shenangians
                    


                    if player.onplatform == e.onplatform then --Detect Charge
                        if e.going == 'left' and player.x < e.x then
                            e.isCharging = true
                        elseif e.going == 'right' and player.x > e.x then
                            e.isCharging = true
                        else
                            --Cant See Enemy
                        end
                    else --If player jumps out of the way
                        if e.isCharging == true then
                            e.ChargeDuration = e.ChargeDuration - .1
                            if e.ChargeDuration < 0 then
                                e.isCharging = false
                                e.ChargeDuration = e.ChargeDurationMax
                                e.hasFC = true
                            end
                        end
                    end

                    if e.hasFC == false then

                        if e.isCharging == true then -- if charging
                            if e.going == 'left' then
                                e.xvel = e.xvel - e.speed
                            else
                                e.xvel = e.xvel + e.speed
                            end
                        end
                        if e.hasShield == true then
                            if breakables[e.shieldID] ~= nil and enemyHitPlayer(player,breakables[e.shieldID])then -- if player gets bonked
                                e.hasFC = true
                                e.isCharging = false
                                player.js = 4
                                player.xvel = player.xvel + e.xvel
                                player.health = player.health - 15

                            end
                        elseif enemyHitPlayer(player,e) then
                            e.hasFC = true
                            e.isCharging = false
                            player.js = 4
                            player.xvel = player.xvel + e.xvel
                            player.health = player.health - 15
                        
                        end
                    else --if boi has finished charging (start cooldown)
                        e.hitCooldown = e.hitCooldown - .1
                        e.xvel = 0
                        if e.hitCooldown < 0 then
                            e.isCharging = false
                            e.hasFC = false
                            e.hitCooldown = e.hitCooldownMax
                            --print('Done')
                        end



                    end



                end

               
        end
            if e.isCharging ~= true then
                if e.xvel > e.maxspeed then
                    e.xvel = e.maxspeed
                end
                if e.xvel < -e.maxspeed then
                    e.xvel = -e.maxspeed
                end
            else
                if e.xvel > e.maxspeed*12 then
                    e.xvel = e.maxspeed*12
                end
                if e.xvel < -e.maxspeed*12 then
                    e.xvel = -e.maxspeed*12
                end
            end
                if e.js > e.jsmax then
                    e.js = e.jsmax
                end
                if e.js < -e.jsmax then
                    e.js = -e.jsmax
                end

                if e.isonground == false then
                    e.js = e.js - e.gravity
                end
                

                e.x = e.x + e.xvel
                e.y = e.y - e.js
                if e.enemyType == 4 then
                    if e.hasShield == true then
                    if breakables[e.shieldID] ~= nil and e.going == 'left' then
                        breakables[e.shieldID].x = e.x - 16
                        breakables[e.shieldID].flip = false
                    end

                    if breakables[e.shieldID] ~= nil and e.going == 'right' then
                        breakables[e.shieldID].x = e.x+e.w
                        breakables[e.shieldID].flip = true
                    end
                    if breakables[e.shieldID] ~= nil then
                     breakables[e.shieldID].y = e.y
                     end
                end
                end
        
        e.gridx = math.floor(((e.x+16-westWall)/32))
        e.gridy = math.floor(((e.y+16)/32))
        

        if e.health <= 0 then
            if e.enemyType == 4 then
                if breakables[e.shieldID] ~= nil then
                        breakables[e.shieldID] = nil
                        
                    end
            end

            if e.enemyType == 'the king' then
                    bg = love.graphics.newImage('assets/bossFightBackground2.png') 
                    gameComplete=true
                    dialogDoneForArea =false
                    --[[pause = true
                    enterDown = false
                    drawDialogBox()
                    printDialog("win")]]
            end

            if math.floor(math.random(1,3)) == 1 then
                createKit(e.x,e.y)
            end
            table.remove(enemies,i)
        end
    end
    for i, e in ipairs(enemies) do
		BulletCollide(e)
	end
end

function enemyHitPlayer(guy,p)
     if guy.x + guy.w > p.x and guy.x < p.x+p.w and guy.y + guy.h > p.y and guy.y < p.y + p.h then -- Hit
            return true
    end

end