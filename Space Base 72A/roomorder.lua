    require"rooms"
    progression = {}
    space = {space1,space2,space3,space4,spaceElevator}
    cellBlock = {cell1,cell2,cell3,cellElevator}
    crystal = {crystal1,crystal2,crystal3,crystal4,crystalElevator}
    lab = {lab1,lab2,lab3,lab4,lab5,labElevator}
    computerRoom = {compElevator, bossRoom}
    stageOrder = {space,cellBlock,crystal,lab,computerRoom}
    areas = {'space','cellBlock','crystal','lab','computerRoom'}
    progression = space --the order of the levels
    currentlvl = 1        --start on the first lvl. This variable will be used to point to the "progression" table, which will have the level data.
    stageIndex = 1
    w = space1[#space1-1]
    h = space1[#space1]
    eastWall = w*32                         --intialize all the walls
    southWall = h*32
    westWall = 0
    northWall = 0   
    startPoint = 0            --used to count level widths as more levels are built so they don't get built on top of each other
    roomCleared = false       --whether the enemies in the room are defeated or not
    elevatorCutscene = false
--lvl means the level as an interger, ie. 1,2,3,4,etc.
--room means it wants the level table
    print(stageIndex)

function findRoomIndex(room)
    if progression[currentlvl] == room then     --check first if it is the currentlvl, which it will be mostly so this'll save math
        return currentlvl
    
    else
        for i=1, #progression do
            if progression[i] == room then       --or iterate through until you get a match
                return i
            end
        end
    end
end

function getWidth(room)                      --returns width of any room
    return room[#room-1]
end
function getHeight(room)                      --returns width of any room
    return room[#room]
end

function getWidthOfAllPreviousRooms(lvl)

    local totalWidth = 0

        for i=1,(lvl-1) do
            totalWidth = totalWidth + getWidth(progression[i])  --find the width of all previous stages
        end

    return totalWidth
end

function defineWestWall(lvl)

    if roomCleared == false then             --if the room isn't cleared, we'll confine them to that room.

        westWall = getWidthOfAllPreviousRooms(lvl)*32   -- set the westWall to the width in tiles of all previous stage multiplied by 32
    end

    if roomCleared == true then              --if the room is cleared, the walls will be set to the edges of the two adjacent rooms.

        westWall = getWidthOfAllPreviousRooms(lvl-1)*32          --same process, but set the wall at the start of the previous level. You'll never
                                                                                --reach this wall because it will reset to a further room when you enter a new one.
    end
end

function defineEastWall(lvl)

    if roomCleared == false then                                --if room isn't cleared, confine them

        eastWall = getWidthOfAllPreviousRooms(lvl+1)*32  --set the eastwall as the width of all previous rooms, plus the current room

    end

    if roomCleared == true then               

        eastWall = getWidthOfAllPreviousRooms(lvl+2)*32  -- set eastwall as the width of all rooms incluing the next one.

    end
end

function defineSouthWall(lvl)  -- rooms can have different heights, but the top of each room will always be the same. To make taller rooms beneat, you will need to place walls
    southWall = getHeight(progression[currentlvl])*32
end

function defineNorthWall(lvl)
    northWall = 0
end

function defineWalls(lvl)
    defineNorthWall(lvl)
    defineSouthWall(lvl)
    defineEastWall(lvl)
    defineWestWall(lvl)
end

function doesPlayerChangeRooms()   --This is too consuming. Perhaps make the stages remember how much width came before them if it has been calculated before so it doesn't get re-calculated

    if player.x > getWidthOfAllPreviousRooms(currentlvl+1)*32 + 32 and progression[currentlvl].hasElevator ~= true        --calculates the right side of the room, and checks if the player goes past it. Rdefines walls for that room. Changes currentlvl.
       then currentlvl = currentlvl + 1

        local temp = progression[currentlvl]
        if temp[#temp-2] == false then
            roomCleared = false
            loadEnemies(progression[currentlvl])
        end
            defineWalls(currentlvl)

    elseif progression[currentlvl].hasElevator == true and player.x > elevatorx*32+96 and player.y+player.h == (elevatory+8)*32 then
        youreInTheElevator()
        return 0
    end


    if player.x < getWidthOfAllPreviousRooms(currentlvl)*32 - 32 then        --calculates the left side of the room, and checks if the player goes behind it
        currentlvl = currentlvl - 1
        defineWalls(currentlvl)
    end

end


function easyWin()          
    if #enemies == 0 and roomCleared == false and progression[currentlvl].hasElevator ~= true  then  -- if you've defeated all your enemies for the first time, then consider the roomCleared.
        roomCleared = true
        local temp = progression[currentlvl]
        temp[#temp-2] = true                    -- Remember that this room is cleared

        if currentlvl ~= #progression then         -- Redefine the walls for the cleared room so they aren't locked in anymore, and create the next level
            createLevel(progression[currentlvl+1])
            defineWalls(currentlvl)
        end
    end
end

function youreInTheElevator()

        stageIndex = stageIndex + 1
        progression = stageOrder[stageIndex]
        currentlvl = 1
        makeAssets(stageOrder[stageIndex])
        startPoint = 0

        elevatorCutscene = true
        timer = 250

        
        
    end


    --lvl.hasElevator = true
    --elevatorx
    --elevatory

 