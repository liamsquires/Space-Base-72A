platform = {}
platforms = {}

elevatorsansson = love.graphics.newImage('assets/elevator-sans-son.png')

platformImage = love.graphics.newArrayImage('assets/platform-tileset.png')

PlainTilesheet = love.graphics.newArrayImage('assets/bg-platform-hitbox-32x.png')
CrystalTilesheet = love.graphics.newArrayImage('assets/crystal-bg.png')
ExceptionsTilesheet = love.graphics.newArrayImage('assets/exceptions-tilesheet.png')
AsteroidTilesheet = love.graphics.newArrayImage('assets/asteroid-tiles.png')
Tilesheet = PlainTilesheet


--Doors
DoorSheet = love.graphics.newArrayImage('assets/door.png')
DoorBottom = love.graphics.newQuad(0, 40, 32, 32, DoorSheet:getDimensions())
DoorMiddle = love.graphics.newQuad(0, 0, 32, 32, DoorSheet:getDimensions())
DoorMiddleHalf = love.graphics.newQuad(0, 0, 32, 16, DoorSheet:getDimensions())

function makeAssets(stage)
    if stage == space then
        Tilesheet = AsteroidTilesheet
        ExceptionsTilesheet = love.graphics.newArrayImage('assets/exceptions-tilesheet.png')
        bgType = 2
        bg=love.graphics.newImage('assets/spaceBackground.png')
        platformImage = love.graphics.newArrayImage('assets/platform-tileset.png')

        elseif stage == cellBlock then
        Tilesheet = love.graphics.newArrayImage('assets/bg-platform-hitbox-32x.png')
        ExceptionsTilesheet = love.graphics.newArrayImage('assets/exceptions-tilesheet.png')
        bgType = 3
        bg=love.graphics.newImage('assets/Big_Bricks.png') 
        platformImage = love.graphics.newArrayImage('assets/platform-tileset.png')

        elseif stage == crystal then
        Tilesheet = CrystalTilesheet
        ExceptionsTilesheet = love.graphics.newArrayImage('assets/exceptions-tilesheet.png')
        bgType = 2
        bg=love.graphics.newImage('assets/Background_crystals.png')
        platformImage = love.graphics.newArrayImage('assets/platform-tileset.png')

        elseif stage == lab then
        Tilesheet = love.graphics.newArrayImage('assets/bg-platform-hitbox-32x.png')
        ExceptionsTilesheet = love.graphics.newArrayImage('assets/exceptions-tilesheet.png')
        bgType = 1
        bg=love.graphics.newImage('assets/grey-bg.png')
        platformImage = love.graphics.newArrayImage('assets/platform-tileset.png')

        elseif stage == computerRoom then
        Tilesheet = love.graphics.newArrayImage('assets/bg-platform-hitbox-32x.png')
        ExceptionsTilesheet = love.graphics.newArrayImage('assets/exceptions-tilesheet.png')
        bgType = 4
        bg=love.graphics.newImage('assets/bossFightBackground1.png')
        platformImage = love.graphics.newArrayImage('assets/platform-tileset.png')
    end

        platformLeft = love.graphics.newQuad(0, 0, 16, 32, platformImage:getDimensions())
        platformMiddle = love.graphics.newQuad(23, 0, 34, 32, platformImage:getDimensions())
        platformRight = love.graphics.newQuad(64, 0, 16, 32, platformImage:getDimensions())

        GroundLeft = love.graphics.newQuad(0, 40, 32, 32, Tilesheet:getDimensions())
        GroundMiddle = love.graphics.newQuad(40, 40, 32, 32, Tilesheet:getDimensions())
        GroundRight = love.graphics.newQuad(80, 40, 32, 32, Tilesheet:getDimensions())
        -- Inner Corners
        GroundRightUp = love.graphics.newQuad(0, 160, 32, 32, Tilesheet:getDimensions())
        GroundRightDown = love.graphics.newQuad(0, 80, 32, 32, Tilesheet:getDimensions())
        GroundLeftUp = love.graphics.newQuad(80, 160, 32, 32, Tilesheet:getDimensions())
        GroundLeftDown = love.graphics.newQuad(80, 80, 32, 32, Tilesheet:getDimensions())
        GroundRightUpLeftDown = love.graphics.newQuad(40, 120, 32, 32, Tilesheet:getDimensions())
        GroundRightDownLeftUp = love.graphics.newQuad(40, 80, 32, 32, Tilesheet:getDimensions())
        -- Walls
        GroundRightWall = love.graphics.newQuad(80, 120, 32, 32, Tilesheet:getDimensions())
        GroundLeftWall = love.graphics.newQuad(0, 120, 32, 32, Tilesheet:getDimensions())
        --Bottom
        GroundLeftBot = love.graphics.newQuad(0, 200, 32, 32, Tilesheet:getDimensions())
        GroundMiddleBot = love.graphics.newQuad(40, 200, 32, 32, Tilesheet:getDimensions())
        GroundRightBot = love.graphics.newQuad(80, 200, 32, 32, Tilesheet:getDimensions())
        --Columns
        GroundUpColumn = love.graphics.newQuad(80, 0, 32, 32, ExceptionsTilesheet:getDimensions())
        GroundMiddleColumn = love.graphics.newQuad(80, 40, 32, 32, ExceptionsTilesheet:getDimensions())
        GroundDownColumn = love.graphics.newQuad(80, 80, 32, 32, ExceptionsTilesheet:getDimensions())
        GroundBelowColumnConnection = love.graphics.newQuad(40, 40, 32, 32, ExceptionsTilesheet:getDimensions())
        GroundAboveColumnConnection = love.graphics.newQuad(40, 80, 32, 32, ExceptionsTilesheet:getDimensions())
end


function platform:create(x,y,w,h,f,type,setpiece)
    newPlatform = {
        x = x*32,
        y = y*32,
        w = w*32,
        h = h,
        friction = f*1.5,
        id = 'platform',
        type = type,
        setpiece = setpiece


        }
        if newPlatform.type == 4 then
            newPlatform.maxHeight = newPlatform.h
            --newPlatform.h = 32
        end
   --print("YES", newPlatform.type, newPlatform.x, newPlatform.y, newPlatform.w, newPlatform.h) PrintTables(newPlatform.setpiece)
    table.insert(platforms,newPlatform)
end
function DrawAllPlatforms()
    for i, p in ipairs(platforms) do
        local belowcheck = false
        local abovecheck = false
        --draw Left piece at x,y. Draw middle piece many times according to the width. Draw final piece at the end (p.x+p.w-16).
        love.graphics.setColor(255,255,255)
        if p.type == 1 then
            love.graphics.draw(platformImage, platformLeft, p.x, p.y)
        for j=2, p.w/32 do
            love.graphics.draw(platformImage, platformMiddle, 16+p.x+(j-2)*32, p.y)
        end
            love.graphics.draw(platformImage, platformRight, p.x+p.w-16, p.y)
        end


     

        if p.type == 3 then

           
             for j=0, (p.h/32)-1 do
                 --determines which piece to draw based on setpiece, then draws it
                    --for j=0, (p.w/32)-1 do --loop as many times as tiles of width
                    if p.setpiece[j+1] == 5 then
                    love.graphics.draw(Tilesheet,GroundLeftWall,p.x,p.y+j*32)
                elseif p.setpiece[j+1] == 6 then
                    love.graphics.draw(Tilesheet,GroundRightWall,p.x,p.y+j*32)
                elseif p.setpiece[j+1] == 16 then
                    love.graphics.draw(ExceptionsTilesheet,GroundUpColumn,p.x,p.y+j*32)
                elseif p.setpiece[j+1] == 17 then
                    love.graphics.draw(ExceptionsTilesheet,GroundDownColumn,p.x,p.y+j*32)
                elseif p.setpiece[j+1] == 18 then
                    love.graphics.draw(ExceptionsTilesheet,GroundMiddleColumn,p.x,p.y+j*32)
                else
                    love.graphics.setColor(255,0,255)
                    love.graphics.rectangle('fill',p.x,p.y+j*32,16,16)
                    love.graphics.rectangle('fill',p.x+16,p.y+j*32+16,16,16)
                    love.graphics.setColor(0,0,0)
                    love.graphics.rectangle('fill',p.x+16,p.y+j*32,16,16)
                    love.graphics.rectangle('fill',p.x,p.y+j*32+16,16,16)
                    
                end
                    
            end
        end

        if p.type == 2 then

             for j=0, (p.w/32)-1 do
                 --determines which piece to draw based on setpiece, then draws it
                    --for j=0, (p.w/32)-1 do --loop as many times as tiles of width
                    if p.setpiece[j+1] == 1 then
                        love.graphics.draw(Tilesheet, GroundMiddle, p.x+j*32, p.y)
                elseif p.setpiece[j+1] == 2 then
                    love.graphics.setColor(255,255,255)
                    love.graphics.setColor(0,0,0)
                    love.graphics.rectangle('fill',p.x+j*32,p.y,32,32)
                    love.graphics.setColor(255,255,255)
                    --Blank Space
                elseif p.setpiece[j+1] == 3 then
                    love.graphics.draw(Tilesheet,GroundLeft,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 4 then
                    love.graphics.draw(Tilesheet,GroundRight,p.x+j*32,p.y)
                --[[elseif p.setpiece[j+1] == 5 then
                    love.graphics.draw(Tilesheet,GroundLeftWall,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 6 then
                    love.graphics.draw(Tilesheet,GroundRightWall,p.x+j*32,p.y)]]
                elseif p.setpiece[j+1] == 7 then
                    love.graphics.draw(Tilesheet,GroundRightBot,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 8 then
                    love.graphics.draw(Tilesheet,GroundMiddleBot,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 9 then
                    love.graphics.draw(Tilesheet,GroundLeftBot,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 10 then
                    love.graphics.draw(Tilesheet,GroundRightUp,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 11 then
                    love.graphics.draw(Tilesheet,GroundRightDown,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 12 then
                    love.graphics.draw(Tilesheet,GroundLeftUp,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 13 then
                    love.graphics.draw(Tilesheet,GroundLeftDown,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 14 then
                    love.graphics.draw(Tilesheet,GroundRightDownLeftUp,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 15 then
                    love.graphics.draw(Tilesheet,GroundRightUpLeftDown,p.x+j*32,p.y)
                --[[elseif p.setpiece[j+1] == 16 then
                    love.graphics.draw(ExceptionsTilesheet,GroundUpColumn,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 17 then
                    love.graphics.draw(ExceptionsTilesheet,GroundDownColumn,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 18 then
                    love.graphics.draw(ExceptionsTilesheet,GroundMiddleColumn,p.x+j*32,p.y)]]
                elseif p.setpiece[j+1] == 19 then
                    love.graphics.draw(ExceptionsTilesheet,GroundBelowColumnConnection,p.x+j*32,p.y)
                elseif p.setpiece[j+1] == 20 then
                    love.graphics.draw(ExceptionsTilesheet,GroundAboveColumnConnection,p.x+j*32,p.y)
                else
                    love.graphics.setColor(255,0,255)
                    love.graphics.rectangle('fill',p.x+j*32,p.y,16,16)
                    love.graphics.rectangle('fill',p.x+j*32+16,p.y+16,16,16)
                    love.graphics.setColor(0,0,0)
                    love.graphics.rectangle('fill',p.x+j*32+16,p.y,16,16)
                    love.graphics.rectangle('fill',p.x+j*32,p.y+16,16,16)
                    
                end
                    
            end
        end

        if p.type == 4 then
                if p.opening or p.closing then
                    if p.h >64  then 
                        love.graphics.draw(DoorSheet, DoorMiddle, p.x, p.y+p.h-64)
                        elseif p.h < 48 then
                            love.graphics.draw(DoorSheet, DoorMiddleHalf, p.x, p.y)
                        elseif p.h < 64 then
                            love.graphics.draw(DoorSheet, DoorMiddle, p.x, p.y)
                    end
                end
             for j=0, p.h/32-2 do
                love.graphics.draw(DoorSheet, DoorMiddle, p.x, p.y+j*32)
            end
                love.graphics.draw(DoorSheet, DoorBottom, p.x, p.y+p.h-32)
        end

        if p.type == 5 then
            love.graphics.draw(elevatorsansson, elevatorx*32,elevatory*32)
            

        end

        if p.type == 6 then
            love.graphics.draw(elevatorsansson, fakeelevatorx*32+9*32,fakeelevatory*32, 0, -1, 1)

        end

    end
end

function CheckIfPlayer(guy)
    for i, p in ipairs(platforms) do
        if guy.loopcountdown == nil then
            guy.loopcountdown = 15
        end
        
        if i+1 ~= guy.onplatform then
        if guy.x + guy.w > p.x and guy.x < p.x+10 and guy.y + guy.h > p.y+10 and guy.y < p.y + p.h-15 then -- Hit on Left
            guy.x = p.x - guy.w
            guy.xvel = 0
            guy.onwall = true
            guy.onwallthisloop = true
            guy.onwalldir = 'right'
            if guy.id == 'player' then
                guy.js = 0
            end
           -- if guy.x + guy.w < p.x-5 and guy.y + guy.h > p.y+10 and guy.y < p.y + p.h-15 then guy.onwall = false 
           -- end
    end
    if guy.x > (p.x+p.w-10) and guy.x < p.x+p.w and guy.y + guy.h > p.y+10 and guy.y < p.y + p.h-15 then -- Hit on Right
            guy.x = p.x + p.w
            guy.xvel = 0
            guy.onwall = true
            guy.onwallthisloop = true
            guy.onwalldir = 'left'
            if guy.id == 'player' then
            guy.js = 0
            end
            if guy.xvel > player.maxspeed then
                guy.xvel= player.maxspeed/2
                guy.x =guy.x+4
                print(true)
            end
        --elseif guy.x > (p.x+p.w-5) and guy.x < p.x+p.w and guy.y + guy.h > p.y+10 and guy.y < p.y + p.h-15 then
         --else guy.onwall = false 
    end
    if guy.x + guy.w/2 > p.x and guy.x < p.x+p.w and guy.y + guy.h > p.y +p.h-15 and guy.y < p.y + p.h and guy.js > 0 then -- Hit From Bottom
        if guy.y > p.y+(p.h/3) then
            guy.y = p.y+p.h
            if p.type == 2 then
                guy.y = guy.y +3
            end

            if guy.js > 0 then
                guy.js = 0
            end
        end
    end
end
    if guy.x + (guy.w/2) > p.x and guy.x < p.x+p.w and guy.y + guy.h > p.y-5 and guy.y < p.y + 10 and guy.js <= 0 then -- Yay We landed!
        guy.isonground = true
        guy.js = 0
        guy.onwall = false
        guy.y = p.y - guy.h
        guy.onplatform = 1+i
    end

        

        if i+1 == guy.onplatform then
            if guy.x + guy.w > p.x and guy.x < p.x + p.w and guy.y + guy.h > p.y - 5 and guy.y < p.y then -- else is here because im too lazy to search this up haha
            else
                guy.isonground = false
                guy.onwall = false
                guy.onplatform = 0
            end
        end

        if i==#platforms and guy.onwallthisloop == false then --walljump glitch
            guy.loopcountdown = guy.loopcountdown - 1
            if guy.loopcountdown == 0 then
                player.onwall = false
                guy.loopcountdown =15
            end
        end
        if i==#platforms then
            guy.onwallthisloop = false
        end
        
    end
end



function PlatformColide(b, dash)
    for i,target in ipairs(platforms) do
        --print(target.x)

        if b.x > target.x and b.x < target.x+target.w and b.y > target.y and b.y < target.y + target.h then
                if dash == 'dash' and target.type ==1 then
                    return false
                end
                return true

        end
    end
end


function updateDoors( ... )
    for i, p in ipairs(platforms) do
        if p.type == 4 then 
            p.opening = false
            p.closing = false
            if #enemies == 0 then
                if p.h > 32 then
                    p.h=p.h-6
                    p.opening = true
                    p.closing = false
                end
                
            else
                if p.h < p.maxHeight then
                        p.h=p.h+6
                        p.closing = true
                        p.opening = false
                end
                
            end
        end
    end
end

