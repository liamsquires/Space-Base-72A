--Get graphics
pipeSheet = love.graphics.newImage('assets/small-pipes.png')
pipes={}
pipes.lr = love.graphics.newQuad(0, 0, 32, 32, pipeSheet:getDimensions())
pipes.ud = love.graphics.newQuad(40, 0, 32, 32, pipeSheet:getDimensions())
pipes.lrd = love.graphics.newQuad(80, 0, 32, 32, pipeSheet:getDimensions())
pipes.lur = love.graphics.newQuad(120, 0, 32, 32, pipeSheet:getDimensions())
--pipes.udw = love.graphics.newQuad(160, 0, 32, 32, pipeSheet:getDimensions()) --this one has the wheel

pipes.rd = love.graphics.newQuad(0, 40, 32, 32, pipeSheet:getDimensions())
pipes.ld = love.graphics.newQuad(40, 40, 32, 32, pipeSheet:getDimensions())
pipes.lud = love.graphics.newQuad(80, 40, 32, 32, pipeSheet:getDimensions())
pipes.urd = love.graphics.newQuad(120, 40, 32, 32, pipeSheet:getDimensions())
pipes.d = love.graphics.newQuad(160, 40, 32, 32, pipeSheet:getDimensions())

pipes.ur = love.graphics.newQuad(0, 80, 32, 32, pipeSheet:getDimensions())
pipes.lu = love.graphics.newQuad(40, 80, 32, 32, pipeSheet:getDimensions())
pipes.u = love.graphics.newQuad(80, 80, 32, 32, pipeSheet:getDimensions())
pipes.l = love.graphics.newQuad(120, 80, 32, 32, pipeSheet:getDimensions())
pipes.r = love.graphics.newQuad(160, 80, 32, 32, pipeSheet:getDimensions())

pipes.blank = love.graphics.newQuad(116, 78, 0, 0, pipeSheet:getDimensions())

function drawPipes(level)
		for i = 0, h-1 do
		    for z = 1, w do
		    	--draws it based on the information in the table within level
		    	if type(level[z+i*w]) == 'table' then
		    		love.graphics.setColor(0,0,0)
                    love.graphics.rectangle('fill',level[z+i*w][2],level[z+i*w][3],tileSize,tileSize)
		    		love.graphics.setColor(0.4,0.4,0.4)
		    		love.graphics.draw(pipeSheet, level[z+i*w][1], level[z+i*w][2], level[z+i*w][3])

		    	end
		    end
		    
		end

	end

	--Select one image
function pickNeither()
	local number = love.math.random(1)
	if number ==1 then
		pipes.img = pipes.rd
		pipes.connections = {true, true} --stores whether it goes right or down, respectively
	elseif number==2 then
		pipes.img = pipes.r
		pipes.connections = {true, false}
	elseif number==3 then
		pipes.img = pipes.d
		pipes.connections = {false, true}
	elseif number==4 then
		pipes.img = pipes.blank
		pipes.connections = {false, false}
	elseif number==5 then
		pipes.img = pipes.blank
		pipes.connections = {false, false}
	elseif number==6 then
		pipes.img = pipes.blank
		pipes.connections = {false, false}
	end
end

function pickLeftUp()
		local number = love.math.random(1, 3)
	if number == 1 then
		pipes.img = pipes.lu
		pipes.connections = {false, false}
		elseif number == 2 then
		pipes.img = pipes.lur
		pipes.connections = {true, false}
		elseif number == 3 then
		pipes.img = pipes.lud
		pipes.connections = {false, true}

	end

end

function pickUp()
	local number = love.math.random(1, 4)
	if number == 1 then
		pipes.img = pipes.ud
		pipes.connections = {false,true}
	elseif number == 2 then
		pipes.img = pipes.urd
		pipes.connections = {true, true}
	elseif number==5 then
		pipes.img = pipes.udw
		pipes.connections = {false,true}
	elseif number==4 then
		pipes.img = pipes.ur
		pipes.connections = {true,false}
	elseif number==3 then
		pipes.img = pipes.u
		pipes.connections = {false,false}
	end
end

function pickLeft()
	local number = love.math.random(1, 3)
	if number == 1 then
		pipes.img = pipes.lr
		pipes.connections = {true,false} 
	elseif number == 2 then
		pipes.img = pipes.ld
		pipes.connections = {false,true}
	elseif number == 3 then
		pipes.img = pipes.lrd
		pipes.connections = {true, true}
	elseif number==4 then
		pipes.img = pipes.l
		pipes.connections = {false,false}
	end
end


function pickImage()
	local number = love.math.random(1, 4)
	if number == 1 then
		pickLeftUp()
	elseif number == 2 then
		pickNeither()
	elseif number == 3 then
		pickLeft()
	elseif number == 4 then
		pickUp()
	end

end