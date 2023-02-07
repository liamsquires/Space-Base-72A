local bossTimer = -100
theBossWasMade = false

function bossAttack(e)
	if bossTimer >= 600 then
		bossTimer = 0
	end

	if bossTimer >= 0 and bossTimer <= 10 and bossTimer %2 == 0 then
		bullet:create(2/16*(math.pi*2),e,6)
		bullet:create(4/16*(math.pi*2),e,6)
		bullet:create(6/16*(math.pi*2),e,6)
		bullet:create(8/16*(math.pi*2),e,6)
		bullet:create(10/16*(math.pi*2),e,6)
		bullet:create(12/16*(math.pi*2),e,6)
		bullet:create(14/16*(math.pi*2),e,6)
		bullet:create(16/16*(math.pi*2),e,6)
	end

	if bossTimer >= 40 and bossTimer <= 50 and bossTimer %2 == 0 then
		bullet:create(1/16*(math.pi*2),e,6)
		bullet:create(3/16*(math.pi*2),e,6)
		bullet:create(5/16*(math.pi*2),e,6)
		bullet:create(7/16*(math.pi*2),e,6)
		bullet:create(9/16*(math.pi*2),e,6)
		bullet:create(11/16*(math.pi*2),e,6)
		bullet:create(13/16*(math.pi*2),e,6)
		bullet:create(15/16*(math.pi*2),e,6)
	end

	if bossTimer == 200 then
		bullet:create(e.angle, e, 5)
	end
	if bossTimer == 202 then
		bullet:create(e.angle + (1/32*(math.pi*2)), e, 5)
	end
	if bossTimer == 204 then
		bullet:create(e.angle - (0.5/32*(math.pi*2)), e, 5)
	end
	if bossTimer == 206 then
		bullet:create(e.angle, e, 5)
	end
	if bossTimer == 208 then
		bullet:create(e.angle + (0.3/32*(math.pi*2)), e, 5)
	end
	if bossTimer == 210 then
		bullet:create(e.angle - (0.2/32*(math.pi*2)), e, 5)
	end
	if bossTimer == 212 then
		bullet:create(e.angle, e, 5)
	end
	if bossTimer == 214 then
		bullet:create(e.angle + (0.2/32*(math.pi*2)), e, 5)
	end
	if bossTimer == 216 then
		bullet:create(e.angle - (0.3/32*(math.pi*2)), e, 5)
	end
		
		
		

	if bossTimer == 400 then
		bullet:create(8/32*(math.pi*2),e,6)
		bullet:create(16/32*(math.pi*2),e,6)
		bullet:create(24/32*(math.pi*2),e,6)
		bullet:create(32/32*(math.pi*2),e,6)
	end
	if bossTimer == 405 then
		bullet:create(9/32*(math.pi*2),e,6)
		bullet:create(17/32*(math.pi*2),e,6)
		bullet:create(25/32*(math.pi*2),e,6)
		bullet:create(1/32*(math.pi*2),e,6)
	end
	if bossTimer == 410 then
		bullet:create(10/32*(math.pi*2),e,6)
		bullet:create(18/32*(math.pi*2),e,6)
		bullet:create(26/32*(math.pi*2),e,6)
		bullet:create(2/32*(math.pi*2),e,6)
	end
	if bossTimer == 415 then
		bullet:create(11/32*(math.pi*2),e,6)
		bullet:create(19/32*(math.pi*2),e,6)
		bullet:create(27/32*(math.pi*2),e,6)
		bullet:create(3/32*(math.pi*2),e,6)
	end
	if bossTimer == 420 then
		bullet:create(12/32*(math.pi*2),e,6)
		bullet:create(20/32*(math.pi*2),e,6)
		bullet:create(28/32*(math.pi*2),e,6)
		bullet:create(4/32*(math.pi*2),e,6)
	end
	if bossTimer == 425 then
		bullet:create(13/32*(math.pi*2),e,6)
		bullet:create(21/32*(math.pi*2),e,6)
		bullet:create(29/32*(math.pi*2),e,6)
		bullet:create(5/32*(math.pi*2),e,6)
	end	if bossTimer == 430 then
		bullet:create(14/32*(math.pi*2),e,6)
		bullet:create(22/32*(math.pi*2),e,6)
		bullet:create(30/32*(math.pi*2),e,6)
		bullet:create(6/32*(math.pi*2),e,6)
	end
	if bossTimer == 435 then
		bullet:create(14/32*(math.pi*2),e,6)
		bullet:create(23/32*(math.pi*2),e,6)
		bullet:create(31/32*(math.pi*2),e,6)
		bullet:create(7/32*(math.pi*2),e,6)
	end


		bossTimer = bossTimer+2

end

function createBoss()
	createEnemy(westWall + 43*32/2-theKing:getWidth()/2, northWall + 35*32/2-theKing:getHeight()/2, 'the king')
end

