kits = {}
kitImage = love.graphics.newImage('assets/kit.png')

-- adds require"kits"
-- main.lua draw function add DrawKits()
-- main.lua kit update into update
function createKit(x,y)
    newKit = {
        x = x,
        y = y,
        w = kitImage:getWidth(),
        h = kitImage:getHeight(),
        img = kitImage,
    }
    table.insert(kits,newKit)
end

function drawKits()
    for i, k in ipairs(kits) do
        love.graphics.draw(k.img,k.x,k.y)
    end
end

function Heal()
    if player.health + (player.maxhealth/10)*3 > player.maxhealth then
        player.health = player.maxhealth
    else
        player.health = player.health + (player.maxhealth/10)*3
    end
end

function KitUpdate()
    for i, k in ipairs(kits) do
        if enemyHitPlayer(player,k) and player.health ~= player.maxhealth then
            Heal()
            table.remove(kits,i)
        end
    end
end