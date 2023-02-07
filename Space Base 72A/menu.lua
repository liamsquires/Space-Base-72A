startMenu = true
pause = false
pauseMenu = false
escWasDown = true

menuPage = 0
windowW,windowH = 1280,720
frameW,frameH = windowW/2,2*(windowH/3)
frameX,frameY = (windowW - frameW)/2,(windowH - frameH)/2
numOfButtons = 5
buttonX,buttonY,buttonW,buttonH = frameX+20,frameY+20,frameW/3,60
buttonGap = (frameH-(buttonH*numOfButtons))/(numOfButtons+1)
infoX,infoY,infoLimit = buttonX+buttonW+20,buttonY,frameW-buttonW-40
cursorImg = love.graphics.newImage('assets/cursor.png')
title = love.graphics.newFont('assets/FFFFORWA.TTF', 40)
menu = love.graphics.newFont('assets/UASQUARE.TTF', 30)
heading = love.graphics.newText(title, "SPACE BASE 72A")
jelly = love.graphics.newImage('assets/jellyguy-menu-2.png')
buttons = {
    love.graphics.newText(menu, 'START'), love.graphics.newText(menu, 'SAVE/LOAD'), love.graphics.newText(menu, 'CONTROLS'), love.graphics.newText(menu, 'CREDITS'), love.graphics.newText(menu, 'EXIT'),
    'START','SAVE/LOAD','CONTROLS','CREDITS','EXIT',love.graphics.newText(menu,'CONTINUE')
}

function initializeMenu()
    --loads all the fonts, images, etc, defines text objects for buttons and title
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", frameX-4,frameY-4,frameW+8,frameH+8,7,7)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", frameX,frameY,frameW,frameH,5,5)
    love.graphics.print("SPACE BASE 72A",title,(windowW-heading:getWidth())/2,40)
end

--[[function music()
    menuMusic = love.audio.newSource("assets/menu-music.m4a", "static")
    love.audio.play(menuMusic)
    love.audio.setVolume(0.5)
end]]

function drawButtons()
    for i=0,numOfButtons-1 do 
        love.graphics.setColor(1,1,1)
        local y = buttonY + i*(buttonH+buttonGap)
        love.graphics.rectangle("line",buttonX,y,buttonW,buttonH,3,3)
    end
end

function hover(button) 
    love.graphics.setColor(0.2,0.2,0.2)
    love.graphics.rectangle("fill", buttonX + 3, buttonY + button*(buttonH+buttonGap) + 3, buttonW - 6, buttonH - 6,3,3)
end

function click(button)
    love.graphics.setColor(0.8,0.8,0.8)
    love.graphics.rectangle("fill", buttonX + 3, buttonY + button*(buttonH+buttonGap) + 3, buttonW - 6, buttonH - 6,3,3)
end

function appendButtonText()
    for i=0,numOfButtons-1 do
        local textY = buttonY + ((buttonH - buttons[i+1]:getHeight())/2) + i*(buttonH+buttonGap)
        local textX = buttonX + ((buttonW - buttons[i+1]:getWidth())/2)
        if pause == true and i == 0 then
            textX = buttonX + ((buttonW - buttons[11]:getWidth())/2)
            love.graphics.print('CONTINUE',menu,textX,textY)
        elseif pause == true and i ~= 0 then
            love.graphics.print(buttons[i+6],menu,textX,textY)
        end
        if pause == false then
        love.graphics.print(buttons[i+6],menu,textX,textY)
        end
    end
end

function printPage(menuPage)
    if menuPage == 0 then
        displayImage()
    elseif menuPage == 1 then
        displaySaves()
    elseif menuPage == 2 then
        displayOptions()
    elseif menuPage == 3 then
        displayCredits()
    end
end


function displayImage()
    love.graphics.draw(jelly,infoX+jelly:getWidth(),infoY)
end
function displaySaves()
    love.graphics.printf('a save function\nis not available\nat this time',menu,infoX,infoY,infoLimit,"center")
end
function displayOptions()
    love.graphics.printf('A - strafe left\nD - strafe right\nW / SPACE - jump\nS - gravity boots\nSHIFT - dash\n\nMOUSE - aim\nL CLICK - shoot\nSCROLL - switch gun\n\nP / ESC - pause\nENTER - progress dialogue\nT - suicide',menu,infoX,infoY,infoLimit,"center")
end
function displayCredits()
    love.graphics.printf('SPACE BASE 72A\n\nBy Tyler Cairns\n\nLiam Squires\n\nScott Squires\n\nNathan Peters\n\nand Athena Abbott\n\nCopyright February 2021',menu,infoX,infoY,infoLimit,"center")
end
function exit()
    love.event.quit()
end

function buttonUpdate()
    printPage(menuPage)
    if (mouseX > buttonX) and (mouseY > buttonY) and (mouseX < buttonX + buttonW) then
        love.graphics.setColor(1,1,1)
        for i=0,4 do
            if mouseY < (buttonY + buttonH + i*(buttonH+buttonGap)) and mouseY > (buttonY + i*(buttonH+buttonGap)) then
                hover(i)
            end
            if mouseY < (buttonY + buttonH + i*(buttonH+buttonGap)) and mouseY > (buttonY + i*(buttonH+buttonGap)) and love.mouse.isDown(1) then 
                click(i)
                if i == 4 then
                    exit()
                elseif i == 0 then
                    startMenu = false
                    pauseMenu = false
                    pause = false
                    escWasDown = false
                    love.load()
                    menuMusic:stop()
                    playAudio()
                elseif i == 1 or 2 or 3 then
                    menuPage = i
                end
            end
        end
    end
    --[[if love.keyboard.isDown("escape") and escWasDown == false then
        startMenu = false
        pauseMenu = false
        pause = false
        escWasDown = false
        love.load()
    end
    if love.keyboard.isDown("escape") then
        escWasDown = true
    end 
    if love.keyboard.isDown("escape") == false then
        escWasDown = false
    end]]
end