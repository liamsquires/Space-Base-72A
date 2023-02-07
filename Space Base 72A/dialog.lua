
dialogW,dialogH = 3*(windowW/4),(windowH/4)
dialogX,dialogY = (windowW - dialogW)/2,(windowH - dialogH - 30)
head = love.graphics.newImage('assets/dialog_head.png')
headX = dialogX + 30
headY = dialogY + (dialogH-head:getHeight())/2
printX = dialogX+head:getWidth()+60
printLimit = dialogW-2*(printX/3)
enterWasDown = true
dialogPage = 1
dialogDoneForArea = true

story = {}
story['space'] = {
    "When the ship drops me off, my programming kicks in and my mission flickers through my head:",
    "THE BASE IS OVERRUN. PURGE IT OF ALL LIFEFORMS. REBOOT THE CENTRAL COMPUTER. YOU MUST NOT FAIL.",
    "My powerful treads will allow me to move swiftly upon any surface. [press A or D to move]"
}
story['cellBlock'] = {
    "As I enter the base my sensor chip reads numerous life signs, all hostile.",
    "My magnets will allow me to cling to the walls here. [press A or D against a wall]",
    "Combining this with jumping [SPACE] gives me superior mobility."
}
story["death"] = {
    "SHIELD POWER AT 0%. CRITICAL FAILURE IMMINENT. SHUTTING DOWN...",
    --"[Press enter to respawn]"
}
story['crystal'] = {
    "These crystals look sinister...",
    "What manner of creatures have invaded here?"
}
story['computerRoom'] = {
    "What is this power?",
    "I feel it reverberating through my circuitry--something big has made its home here, inside the computer..."
}
story['lab'] = {
    "By dashing [L SHIFT] I can rise through platforms, and outmaneuver even the most tricky enemies."
}


        


function drawDialogBox()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", dialogX-4,dialogY-4,dialogW+8,dialogH+8,7,7)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", dialogX,dialogY,dialogW,dialogH,5,5)
    love.graphics.draw(head,headX,headY)
end 

function printDialog(area)
    area = area
    dialogX,dialogY = camera.xisGonnaBe+(windowW - dialogW)/2,camera.yisGonnaBe+(windowH - dialogH - 30)
    dialogW,dialogH = 3*(windowW/4),(windowH/4)
    headX = dialogX + 30
    headY = dialogY + (dialogH-head:getHeight())/2
    printX = dialogX+head:getWidth()+60
    printLimit = dialogW-220

    if story[area][dialogPage] == nil or story[area][dialogPage] == false then
        if area == "win" then
            love.event.quit()
        else
        pause = false
        dialogPage = 1
        dialogDoneForArea = true
        if player.death ==true then
         player.returnbydeath = player.returnbydeath + 1
          player.death = false
        end

         end
    else
        love.graphics.printf(story[area][dialogPage],menu,printX,dialogY+40,printLimit,'left')

        if love.keyboard.isDown("return") and enterWasDown == false then
            enterWasDown = true
            dialogPage = dialogPage+1
            printDialog(area)
        end
    end
    if love.keyboard.isDown("return") then
        enterWasDown = true
    end 
    if love.keyboard.isDown("return") == false then
        enterWasDown = false
    end
end