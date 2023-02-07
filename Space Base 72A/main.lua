require"platform"
require"player"
require"gun"
require"camera"
require"projectiles"
require"level"
require"enemy"
require"pipes"
require"rooms"
require"menu"
require"cursor"
require"dialog"
require"drawElevator"
require"pickups"
require"boss"
require"music"
loaded = false
gameComplete=false
function love.load()
    drawCursor()
    if startMenu == true and loaded == false then
        makeAssets(stageOrder[stageIndex])
        createLevel(progression[currentlvl])
        player:load()
        loadCamera()
        playAudio()
    end
    if startMenu == false and loaded == false then
        loadEnemies(progression[currentlvl])
        defineWalls(currentlvl)
        --createEnemy(12,15,3)
        dialogDoneForArea = false
        loaded = true
    end 
end


function love.wheelmoved(x,y)
   
    if player.gunequipped == 'singleshot' then
        if gundebugging == true or player.hascannon == true then
            player.gunequipped = 'cannon'
        end
    else
        player.gunequipped = 'singleshot'
    end
    
end

function love.update()
    if love.keyboard.isDown("escape") or love.keyboard.isDown("p") then
        pause = true
        pauseMenu = true
        --escWasDown = true
    end
    if startMenu == false and pause == false and elevatorCutscene == false then
        camera.update()
        player.update(dt)
        updateDoors()
        CheckIfPlayer(player)
        gun.update()
        updateEnemies()
        updateBullets()
        easyWin()
        KitUpdate()
        doesPlayerChangeRooms()
        BreakableUpdate()
    end
end


function love.draw(dt)
        love.graphics.translate(-1*camera.xisGonnaBe,-1*camera.yisGonnaBe)
        love.graphics.setColor(1,1,1)
        if startMenu == false and loaded == true and elevatorCutscene == false and gameComplete==false then
            drawBG()
            drawBullets()
            DrawAllPlatforms()
            drawEnemies()
            BreakableDraw()
            drawKits()
            if player.death == false then
                drawPlayer()
            else 
                pause = true
                enterDown = false
                drawDialogBox()
                printDialog("death")
                player.x = player.startPointx
               player.y = player.startPointy
               if progression==lab and currentlvl==5 then
                    enemies={}
                    breakables={}
                    loadEnemies(progression[currentlvl])
                end
            end
        if love.keyboard.isDown("t") then
            player.death = true
        end
            love.graphics.translate(camera.xisGonnaBe,camera.yisGonnaBe)
        end
    --------
    if dialogDoneForArea == false and gameComplete == false then
        pause = true
        enterDown = false
        drawDialogBox()
        printDialog(areas[stageIndex])
    end
    if gameComplete == true and dialogDoneForArea ==false then
        drawBG()
        DrawAllPlatforms()
        drawPlayer()
        --dialogDoneForArea=false
        story['win'] = {
            "With that vile creature removed from the central computer, my task here is done.",
            "When the signal reaches home base I will be retrieved, and assigned a new mission...",
            "Deaths:"..player.returnbydeath
        }
        pause = true
        enterDown = false
        drawDialogBox()
        printDialog('win')
    end

    if startMenu or (pause and pauseMenu) then
        mouseX,mouseY = love.mouse.getPosition()
        initializeMenu()
        buttonUpdate()
        drawButtons()
        --music()
        appendButtonText()
    end
    -------
    if elevatorCutscene then
        drawElevatorCutscene()
        dialogDoneForArea = false
    end
end
    

function PrintTables(t)
    for i = 1, #t do
        print('b',t[i],i)
    end
end