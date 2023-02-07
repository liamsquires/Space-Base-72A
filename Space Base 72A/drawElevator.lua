  local elevator = love.graphics.newImage("assets/elevator.png")
  local shaft = love.graphics.newImage("assets/elevator-shaft.png")
  local wheel = love.graphics.newImage("assets/elevator-wheel.png")

   local wheelRotation = 0
   local shaftMovement = 0

   function drawElevatorCutscene()
        
   	camera.xisGonnaBe = 0
   	camera.yisGonnaBe = 0

        	love.graphics.draw(shaft,0,0 - shaftMovement)
        	love.graphics.draw(wheel, 59+wheel:getWidth()/2+32*15, camera.height/2 - elevator:getHeight()/2 - 15+(wheel:getHeight()/2), wheelRotation, 1, 1, wheel:getWidth()/2,wheel:getHeight()/2)
        	love.graphics.draw(elevator, 16+32*15,camera.height/2 - elevator:getHeight()/2)

        	wheelRotation = wheelRotation + 0.1
        	shaftMovement = shaftMovement + 5
        	timer = timer - 1
        	if timer < 0 then
        		elevatorCutscene = false
            
            platforms = {}
            enemies = {}
        createLevel(progression[currentlvl])

        player.x = player.startPointx
        player.y = player.startPointy
        player.xvel = 0
        player.yvel=0
        loadCamera()
        defineWalls(currentlvl)
        playAudio()
        player:load()
        dialogDoneForArea = false
        print("finished initializing the new shit")
        	end
end

