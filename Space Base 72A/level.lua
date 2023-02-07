require"platform"
require"pipes"
tileSize = 32
startPoint = 0            --used to count level widths as more levels are built so they don't get built on top of each other
shaft2 = love.graphics.newImage('assets/elevator-shaft2.png')
--Corner pieces, then touching the wall, then exception pieces
function setBG(w,l,background)
    pos ={w,l}
    table.insert(background, pos)
end
function drawBG()
    love.graphics.setColor(1,1,1)
    --print('run')
    if bgType == 2 then
        love.graphics.draw(bg, camera.xisGonnaBe - player.x*0.02, camera.yisGonnaBe)
        return
    elseif bgType == 1 or bgType==3 then
        for i=1, #progression[currentlvl].background do
            love.graphics.draw(bg, progression[currentlvl].background[i][1], progression[currentlvl].background[i][2])
        end

        if  progression[currentlvl+1] ~= nil and progression[currentlvl+1].background ~=nil then
            for i=1, #progression[currentlvl+1].background do
            love.graphics.draw(bg, progression[currentlvl+1].background[i][1], progression[currentlvl+1].background[i][2])
            end
        end

        if progression[currentlvl-1] ~= nil and progression[currentlvl-1].background ~=nil then
            for i=1, #progression[currentlvl-1].background do
            love.graphics.draw(bg, progression[currentlvl-1].background[i][1], progression[currentlvl-1].background[i][2])
            end
        end
    elseif bgType == 4 then
        love.graphics.draw(bg, camera.xisGonnaBe, camera.yisGonnaBe)
    end

    if fakeelevatorx ~= nil and fakeelevatory ~= nil then
        love.graphics.draw(shaft2, fakeelevatorx*32-23, fakeelevatory-1028)
    end
     drawPipes(progression[currentlvl])
            if progression[currentlvl+1] ~= nil then
                drawPipes(progression[currentlvl+1])
            end
            if progression[currentlvl-1] ~= nil then
                drawPipes(progression[currentlvl-1])
            end
end

function checkForOpenSpace(tile)
    if tile == 0 or tile==1 or tile==3 or tile==4 or tile==5 or tile==6 or tile==7 or tile==13 or tile==17 or tile==18 then
        return true
    end
end

function addEnemy (lvl,enemyInfo)
    table.insert(lvl.enemyTable, enemyInfo)
end

function loadEnemies(lvl)
    for i=1, #lvl.enemyTable do
        createEnemy(lvl.enemyTable[i][1],lvl.enemyTable[i][2],lvl.enemyTable[i][3],lvl.enemyTable[i][4])
    end
end

function createLevel(lvl)
local tempvar = #lvl -- Length of Level
lvl.background={}
lvl.enemyTable = {}
w = lvl[tempvar-1]
h = lvl[tempvar]
--lvl[tempvar-1] = nil
--lvl[tempvar] = nil

print(w, h)
local setpiecesWalls = {}
local doorlength = {}
local breakablelength = {}
for j=1, w do
    setpiecesWalls[j] = {} --a table for each column of tiles, which will act like groundlength
    doorlength[j] = 0
    breakablelength[j] = 0
end

for i = 0, h-1 do --height
    local platformlength = 0
    local groundlength = 0
    local setpieces = {}
    
    
    for z = 1, w do --width
     local currentTile = lvl[z+(i*w)]
     
     local zadjustment = z + startPoint

        if lvl[z+(i*w)] == 1 then --lvl[z+(i*w)] == current tile
                platformlength = platformlength + 1 --accumulate number for length of platforms (1's) next to each other
                
            else
                if platformlength > 0 then --Kind of like battleship, once one end stops being a hit, the size of the boat is found
                platform:create(zadjustment-platformlength-1,i,platformlength,32,.2,1)
                
                platformlength = 0
                end
        end
        if platformlength > 0 and z==w then --in case a platform ends at the width
                platform:create(zadjustment-platformlength,i,platformlength,32,.2,1)
        end



        
        if bgType==3 and z%4 ==1 and (i)%4==0 and i ~= h-1 then
            setBG((zadjustment-1)*32,i*32, lvl.background)

        end
        if bgType==1 and z%2 ==1 and (i)%2==0 and i ~= h-1 then
            setBG((zadjustment-1)*32,i*32, lvl.background)

        end


        if currentTile == 2 then --Is it a wall, ceiling, or floor?
            local setpiece = 0
            local leftTile = lvl[z+(i*w)-1] -- except when z=1, add special cases later
            local rightTile = lvl[z+(i*w)+1]--except when z=w
            local aboveTile = lvl[z+(i*w)-w] --except when i=0
            local belowTile = lvl[z+(i*w)+w] --except when i=h
            local leftUpTile = lvl[z+(i*w)-w-1]
            local rightUpTile = lvl[z+(i*w)-w+1]
            local leftBelowTile = lvl[z+(i*w)+w-1]
            local rightBelowTile = lvl[z+(i*w)+w+1]

            local ceiling = false
            local floor = false
            local wallLeft = false
            local wallRight = false
            local contained = false


            if z == 1 then --if it's in the first row, it shouldn't consider the last on in the previous row the tile to it's left.
                leftTile = nil
                leftBelowTile = nil
                leftUpTile = nil
            end
            if z == w then --likewise for the end of a row
                rightTile = nil
                rightBelowTile = nil
                rightUpTile = nil
            end

                --if bordering an open space, become a border
                if checkForOpenSpace(leftTile) then
                    wallLeft = true
                end
                if checkForOpenSpace(rightTile) then
                    wallRight = true
                end
                if checkForOpenSpace(aboveTile) then
                    floor = true
                end
                if checkForOpenSpace(belowTile) then
                    ceiling = true
                end

                --Errors
                if ceiling == true and floor ==true then
                    print("ERROR:Will never work", z, i)
                end


                --Check if it's surrounded by other ground
                if ceiling ==false and floor ==false and wallRight == false and wallLeft==false then
                    contained = true
                end

                    -- 1 Top Middle Piece, 2 Black Space, 3 Top Left Corner
                    -- 4 Top Right Corner, 5 Left Wall, 6 Right Wall
                    -- 7 Bottom Right Corner, 8 Bot Mid, 9 Bot Left Corner
                    -- 10 Right Up Corner, 11 Right Down Corner, 12 Left Up Corner, 13 Left Down Corner
    
                if wallLeft == true and ceiling==true then
                    setpiece=9
                elseif wallLeft == true and floor==true then
                    setpiece=3
                elseif wallRight == true and ceiling==true then
                    setpiece=7
                elseif wallRight== true and floor==true then
                    setpiece=4
                elseif wallRight ==true then
                    setpiece=6
                    
                elseif wallLeft == true then
                    setpiece=5
                elseif floor == true then
                    setpiece=1
                elseif ceiling == true then
                    setpiece=8
                else
                    setpiece=2
                end

                --Columns
                if wallRight == true and wallLeft==true then
                    if floor == true then
                        setpiece = 16
                    elseif ceiling == true then
                        setpiece = 17
                    else
                        setpiece = 18
                    end
                end

                --check if bordering other 2's
                if contained ==true then
                    
                    if checkForOpenSpace(leftUpTile) then --wall above and floor left
                       setpiece=10

                    elseif checkForOpenSpace(rightUpTile) then --wall above and floor right
                        setpiece = 12


                    elseif checkForOpenSpace(leftBelowTile) then --wall below and floor left
                        setpiece=11

                    elseif checkForOpenSpace(rightBelowTile) then --wall below and floor right
                        setpiece = 13

                    end
                

                        --Goddam Tyler and his goddam funky diagonal
                    if checkForOpenSpace(leftUpTile) and checkForOpenSpace(rightBelowTile) then --wall above and floor left
                           setpiece=15

                        elseif checkForOpenSpace(rightUpTile) and checkForOpenSpace(leftBelowTile) then --wall above and floor right
                            setpiece = 14

                    end


                        --Columns
                    if checkForOpenSpace(leftUpTile) and checkForOpenSpace(rightUpTile) then
                            setpiece = 19
                        elseif checkForOpenSpace(leftBelowTile) and checkForOpenSpace(rightBelowTile) then
                                setpiece =20
                    end
                 --These last if statements works under the assumption that the level is properly designed 
                    --i.e all shapes are at least 2x2, therefore the position of the 0s is completely telling
                end
               
               if setpiece ~= 5 and setpiece ~= 6 and setpiece ~= 16 and setpiece ~= 17 and setpiece ~= 18 then --not a wall
                
                    groundlength = groundlength + 1
                    table.insert(setpieces, setpiece)

                    if #setpiecesWalls[z] > 0 then
                        --#setpiecesWalls[z] is wallHeight
                        platform:create(zadjustment-1,i-#setpiecesWalls[z],1,#setpiecesWalls[z]*tileSize,.2,3,setpiecesWalls[z])
                        setpiecesWalls[z]={}

                    end
                else
                    table.insert(setpiecesWalls[z], setpiece)
                    if groundlength > 0 then 
                     platform:create(zadjustment-1-groundlength,i,groundlength,tileSize,.2,2,setpieces)
                     groundlength = 0
                     setpieces = {}
                end
                end
        else
                if groundlength > 0 then 
                platform:create(zadjustment-1-groundlength,i,groundlength,tileSize,.2,2,setpieces)
                groundlength = 0
                setpieces = {}
                end
                if #setpiecesWalls[z] > 0 then
                        platform:create(zadjustment-1,i-#setpiecesWalls[z],1,#setpiecesWalls[z]*tileSize,.2,3,setpiecesWalls[z])
                        setpiecesWalls[z]={}

                    end
        end
        if groundlength > 0 and z==w then 
                platform:create(zadjustment-groundlength,i,groundlength,tileSize,.2,2,setpieces)
                groundlength=0
                
        end
        if #setpiecesWalls[z] > 0 and i==h-1 then
                        platform:create(zadjustment-1,i-#setpiecesWalls[z],1,#setpiecesWalls[z]*tileSize,.2,3,setpiecesWalls[z])
                        setpiecesWalls[z]={}

        end


        if currentTile == 3 then
            doorlength[z] = doorlength[z]+1

        elseif doorlength[z] > 0 then
                platform:create(zadjustment-1,i-doorlength[z],1,doorlength[z]*32,.2,4)
                
                doorlength[z] = 0
                

        end

        if currentTile == 8 then
            breakablelength[z] = breakablelength[z]+1

        elseif breakablelength[z] > 0 then
                newBreakable((zadjustment-1)*32,(i-breakablelength[z])*32,32,breakablelength[z]*32,'breakyboi')
                
                breakablelength[z] = 0
                

        end


        if currentTile == 9 then
    
            local leftTile = lvl[z+(i*w)-1]
            local aboveTile = lvl[z+(i*w)-w]
                    --This next commented bit will fix this issue: when z=1, the tile will attempt to connect to the last tile in the previous row. 
                    --It's almost indistinguishable, I figured it wasn't worth the math, but here is the fix in case I change my mind
                    --[[if z == 1 then 
                            if i == 0 then
                                --This adds a 0th element to level so that the if statements will work for i=0,z=1
                                 lvl[0] = {}
                            end

                        
    
                        local number = love.math.random(1,2)
                            if number == 1 then
                                lvl[z+(i*w)-1][5]=false
                            else
                                lvl[z+(i*w)-1][5]=true
                            end
                    end]]
                    if i>0 and type(aboveTile) == 'table' and type(leftTile) == 'table'then
                        if lvl[z+(i*w)-1][5] == true and lvl[z+(i*w)-w][4] == true then --both
                            pickLeftUp()
                        elseif  lvl[z+(i*w)-1][5] == true and lvl[z+(i*w)-w][4] == false then --L
                            pickLeft()
                        elseif lvl[z+(i*w)-1][5] == false and lvl[z+(i*w)-w][4] == false then --neither
                            pickNeither()
                        elseif lvl[z+(i*w)-1][5] == false and lvl[z+(i*w)-w][4] == true then --U
                            pickUp()
                        end
                    elseif type(aboveTile) == 'table' then --Pick one with any left connection but specific up connection
                        if aboveTile[4]==true then
                            local number = love.math.random(1,2)
                            if number == 1 then
                                pickUp()
                            else
                                pickLeftUp()
                            end
                        else
                            local number = love.math.random(1,2)
                            if number == 2 then
                                pickNeither()
                            else
                                pickLeft()
                            end
                        end
                    elseif type(leftTile) == 'table' then --pick on with any up connection but specific left
                        if leftTile[5] == true then
                            local number = love.math.random(1,2)
                            if number == 1 then
                                pickLeft()
                            else
                                pickLeftUp()
                            end
                        else
                            local number = love.math.random(1,2)
                            if number == 2 then
                                pickNeither()
                            else
                                pickUp()
                            end
                        end
                    else 
                        pickImage()
                    end

                    --This is the output. It changes the 0 that was in the table level to a new table, containing information about how to draw the tile.
                lvl[z+(i*w)] = {pipes.img,(zadjustment-1)*tileSize,i*tileSize}
                
                --This stores whether the tile has a downward connecion in that same table so that the tile below it can read it.
                if pipes.connections[2]==true then
                    lvl[z+(i*w)][4] = true
                else
                    lvl[z+(i*w)][4] = false
                end

                if pipes.connections[1]==true then
                    lvl[z+(i*w)][5] = true
                else
                    lvl[z+(i*w)][5] = false
                end


         end
        if currentTile == 4 then
            local leftTile = lvl[z+(i*w)-1] 
            local rightTile = lvl[z+(i*w)+1]
            local aboveTile = lvl[z+(i*w)-w]
            local belowTile = lvl[z+(i*w)+w] 
            if belowTile ==2 or belowTile ==1 then
                addEnemy(lvl, {zadjustment-1,i,2,0})

            elseif rightTile ==2 or rightTile ==1 then
                addEnemy(lvl, {zadjustment-1,i,2,3})

            elseif leftTile ==2 or leftTile ==1 then
                addEnemy(lvl, {zadjustment-1,i,2,1})

            else
                addEnemy(lvl, {zadjustment-1,i,2,2})
            end
        end

        if currentTile == 5 then
            addEnemy(lvl, {zadjustment-1,i,1,0})
         end

        if currentTile == 6 then
            addEnemy(lvl, {zadjustment-1,i,3,0})
           end

        if currentTile == 7 then
            addEnemy(lvl, {zadjustment-1,i,4,0})
           end

        if currentTile == 13 then
            player.startPointx = (zadjustment-1)*32
            player.startPointy = i*32
           
        end

        if currentTile == 17 then
            lvl.hasElevator = true
            elevatorx = zadjustment-1
            elevatory = i
            platform:create(zadjustment-1,i+8,8,32,.2,5)
            platform:create(zadjustment+7,i,1,9*32,.2,5)
            platform:create(zadjustment+5,i+1,2,64,.2,5)
        end

        if currentTile == 18 then
            fakeelevatorx = zadjustment-1
            fakeelevatory = i
            platform:create(zadjustment-2/6,i+8,8,32,.2,6)
            platform:create(zadjustment-5/6,i+2/6,1,9*32,.2,6)
            platform:create(zadjustment,i+4/6,2,64,.2,6)
        end

        end

        
        

    end

    startPoint = startPoint + getWidth(lvl)  --adjust startPoint for next room
end

