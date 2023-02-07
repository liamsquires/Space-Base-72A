firstMovement = love.audio.newSource('assets/First Movement.wav', "stream")
trapRoom = love.audio.newSource('assets/Trap-Room.mp3',"stream")
menuMusic = love.audio.newSource('assets/menuMusic.mp3',"stream")


		menuMusic:setLooping(true)
		firstMovement:setLooping(true)
		trapRoom:setLooping(true)
		menuMusic:setVolume(0.65)

function playAudio()
if startMenu == true then
		menuMusic:play()
	end

	if menuMusic:isPlaying() ~= true and (areas[stageIndex] == 'space' or areas[stageIndex] == 'crystal') then
		trapRoom:play()
		if firstMovement:isPlaying() then
			firstMovement:stop()
		end
	elseif  menuMusic:isPlaying() ~= true and (areas[stageIndex] == 'cellBlock' or areas[stageIndex] == 'lab' or areas[stageIndex] == 'computerRoom') then
		firstMovement:play()
			if trapRoom:isPlaying() then
				trapRoom:stop()
			end
	end
end