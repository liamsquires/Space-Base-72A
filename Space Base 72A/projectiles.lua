--Add updateBullets and drawBullets to main.lua, make sure you have the updated gun.lua. The bullets should look like they're shooting out of the gun once the gun isn't upside down when you turn around.
bullet = {}
bullets = {}
local laserImg = love.graphics.newImage('assets/laser.png')
local shootingSoundEffect = love.audio.newSource('assets/shootingSoundEffect2.mp3', "static")
gettingHitSoundEffect = love.audio.newSource('assets/gettingHitSoundEffect2.mp3', "static")
shootingSoundEffect:setVolume(0.6)
gettingHitSoundEffect:setVolume(0.4)



function bullet:create(dir, entity, damage) --Entity is who shoots it
    newBullet = {
        x = entity.x+(entity.w*1/2),
        y = entity.y+(entity.h/2)-4,
        w = laserImg:getWidth(),
        h = laserImg:getHeight(),
        vel = 18,
        direction = dir,
    	team = entity.id,
        diry = math.sin(dir),
        dirx = math.cos(dir),
		damage = damage,
        }
    
    table.insert(bullets,newBullet)
end

function updateBullets()
	gun.cooldown = gun.cooldown - .3

	--Check if the player is shooting
	if love.mouse.isDown(1) == true and gun.cooldown <= 0 then
		if player.gunequipped == 'singleshot' then
			gun.image = singleshot
		bullet:create(gun.angle, player, 4)
		shootingSoundEffect:play()
		end
		if player.gunequipped == 'cannon' then
			for z = 1, 4 do
				gun.image = cannon
			bullet:create(math.rad(math.deg(gun.angle) - math.random(-15,15)), player, 1.5)
			shootingSoundEffect:play()
			end
		end

		gun.cooldown = gun.fireRate
	end

	--Move the bullets
	for i, b in ipairs(bullets) do
		b.x = b.x + b.dirx*b.vel
		b.y = b.y + b.diry*b.vel

	end


	--Delete bullets that have gone off the grid
	for i, b in ipairs(bullets) do
		if b.x < 0 or b.x > eastWall or b.y > southWall or b.y < 0 then
			table.remove(bullets, i)
		end

		local test
    	local testPoint = {}
        testPoint.x=b.x + b.dirx*6
        testPoint.y=b.y+b.diry*6
         
        if PlatformColide(testPoint) then
			table.remove(bullets,i)
        	--print('BULLET BLOCKED? ',true)
		elseif select(1,BreakableColide(testPoint)) then
			table.remove(bullets,i)
			--print('BULLET BLOCKED BY SHIELD')
			breakables[select(2,BreakableColide(testPoint))].hits = breakables[select(2,BreakableColide(testPoint))].hits - 1
		else
			b.x = b.x + b.dirx*b.vel
			b.y = b.y + b.diry*b.vel
        end






	end
	for i, p in ipairs(platforms) do -- here because platforms have no update
		BulletCollide(p)
	end
end 

function drawBullets()
	for i, b in ipairs(bullets) do
		love.graphics.push()
		love.graphics.translate(b.x, b.y)
		love.graphics.rotate(b.direction)
		love.graphics.setColor(1,1,1)
		love.graphics.draw(laserImg, 0, 0, rotation,1)
		love.graphics.pop()
	end

	
end


function BulletCollide(target) --Target needs to be Table {}

	for i,b in ipairs(bullets) do
		if b.x+b.w/2 > target.x and b.x+b.w/2 < target.x+target.w and b.y+b.h/2 > target.y and b.y+b.h/2 < target.y + target.h then
			if target.id == 'platform' then
				table.remove(bullets,i)
			end
			if target.id == 'enemy' and b.team ~= 'enemy' then
				target.health = target.health - b.damage
				table.remove(bullets,i)
			end
			if target.id == 'player' and b.team ~= 'player' then
				target.health = target.health - b.damage
				table.remove(bullets,i)
				print(player.health)
				gettingHitSoundEffect:play()
			end
			if target.id == 'shield' then
				target.hits = target.hits - 1
				print(target.hits)
				table.remove(bullets,i)
				
			end
		else
			
		end

	end


end