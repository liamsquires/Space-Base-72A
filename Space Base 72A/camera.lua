require"roomorder"
camera = {}


function loadCamera()

    camera.width = love.graphics.getWidth()
    camera.height = love.graphics.getHeight()
    camera.xshouldBe = 0
    camera.yshouldBe = 0
    camera.xwantsToBe = math.floor(player.x+player.w/2 - camera.width/2)
    camera.ywantsToBe = math.floor(player.y+player.h/2 - camera.height/2)
    camera.xisGonnaBe = camera.xshouldBe
    camera.yisGonnaBe = camera.yshouldBe
end

function makeCloser(a,b)  --make a closer to b

  if camera[a] > camera[b] then
    if camera[a] - panningSpeed < camera[b] then
      camera[a] = camera[b]
    else
      camera[a] = camera[a] - panningSpeed
    end
  elseif a < b then
    if camera[a] + panningSpeed > camera[b] then
      camera[a] = camera[b]
    else
      camera[a] = camera[a] + panningSpeed
    end
  end
end



function findWhatCameraShouldBe(c)

    
    if c.rightmost >= eastWall then
      c.xshouldBe = eastWall - c.width
    elseif c.leftmost <= westWall then
      c.xshouldBe = westWall
    else
      c.xshouldBe = c.xwantsToBe
    end
    if c.bottom >= southWall then
        c.yshouldBe = southWall - c.height
      elseif camera.top <= northWall then
        c.yshouldBe = northWall
      else
        c.yshouldBe = c.ywantsToBe
      end
end

function slowPan()
    panningSpeed = 12

    if camera.xisGonnaBe ~= camera.xshouldBe then
      makeCloser("xisGonnaBe", "xshouldBe")
    end

    if camera.yisGonnaBe ~= camera.yshouldBe then
      makeCloser("yisGonnaBe", "yshouldBe")
    end
end


function camera.update()
    camera.xwantsToBe = math.floor(player.x+player.w/2 - camera.width/2)
    camera.ywantsToBe = math.floor(player.y+player.h/2 - camera.height/2)

    camera.leftmost = player.x+player.w/2 - camera.width/2
    camera.rightmost = player.x+player.w/2 + camera.width/2
    camera.top = player.y+player.h/2 - camera.height/2
    camera.bottom = player.y+player.h/2 + camera.height/2

    findWhatCameraShouldBe(camera)
    slowPan()

 end

