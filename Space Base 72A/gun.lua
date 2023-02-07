--Add gun.update() to update, and gun.draw() to draw. Both need information from player so put them under player update, player draw, etc.

gun = {}
mouse = {}
gun.angle = 0
gun.quadrant = 0
gun.fireRate = 4
gun.cooldown = gun.fireRate
singleshot = love.graphics.newImage('assets/gun-arm.png')
cannon = love.graphics.newImage('assets/cannon-arm.png')
gun.image = singleshot
gundebugging = true

function gun.update()
	--Get mouse position
	mouse.x, mouse.y = love.mouse.getPosition( )
	--Calculate mouse position relative to player (named gun.x gun.y, though not actually the x and y of the gun)
	gun.x = (mouse.x+camera.xisGonnaBe) - (player.x+(player.w*1/2))
	gun.y = (camera.yisGonnaBe+mouse.y) - (player.y+(player.h/2)-4)
	--Inverse tangent to get angle to mouse
	gun.angle = math.atan(gun.y/gun.x)
	--The tangent returns only for quadrant 1 and 4, so if the mouse is behind the player it will be 180 degress off
	if gun.x < 0 then
		gun.angle = gun.angle + math.pi
	end
	--Determine quadrant relative to player that the mouse was clicked
	if gun.x < 0 and gun.y < 0 then
		gun.quadrant = 2
		elseif gun.x > 0 and gun.y < 0 then
			gun.quadrant = 1
		elseif gun.x < 0 and gun.y > 0 then
			gun.quadrant = 3
		elseif gun.x > 0 and gun.y > 0 then
			gun.quadrant = 4
		end

		if player.gunequipped == 'singleshot' then
			gun.image = singleshot
		else
			gun.image = cannon
		end

end

function gun.draw()
	
	if gun.angle > 1.5 then
		--Translate to the middle of the player, rotate to the mouse, then draw the gun at 0, 0
	 love.graphics.push()
	 love.graphics.setColor(255, 255, 255)
	 love.graphics.translate(player.x+(player.w*1/2), player.y+(player.h/2))
	 love.graphics.rotate(gun.angle)
	 love.graphics.draw(gun.image, 0, 12, 0, 1, -1)
	 love.graphics.setColor(255, 255, 255)
	 love.graphics.pop()
	 --print(angle)
	else
	--Translate to the middle of the player, rotate to the mouse, then draw the gun at 0, 0
	love.graphics.push()
	love.graphics.setColor(255, 255, 255)
	love.graphics.translate(player.x+(player.w*1/2), player.y+(player.h/2))
	love.graphics.rotate(gun.angle)
	love.graphics.draw(gun.image, 0, -8)
	love.graphics.setColor(255, 255, 255)
	love.graphics.pop()
	--print(angle)
	end


end
