
breakables = {}

shield = love.graphics.newImage('assets/devilshield.png')
function NewBreakable(x,y,w,h,id)
    newBreakable = {
        hits = 10,
        x = x,
        y = y,
        w = w or shield:getWidth(),
        h = h or shield:getHeight(),
        id = id or 'shield',
        flip = false
    }
    table.insert(breakables,newBreakable)
    print(#breakables)
end

function BreakableUpdate()
    for i, b in ipairs(breakables) do
        BulletCollide(b)
        


    end
end

function BreakableDraw()
    for i ,b in ipairs(breakables) do
        if b.id == 'shield' then -- If Enemy Shield
            if b.hits > 0 then
                if b.flip == false then
                    love.graphics.draw(shield,b.x,b.y)
                elseif b.flip == true then
                    love.graphics.draw(shield,b.x,b.y,0,-1,1,b.w,0)
                end
            end
        end
    end
end

function BreakableColide(b)
    for i,target in ipairs(breakables) do
        --print(target.x)
        if target ~= nil and b.x > target.x and b.x < target.x+target.w and b.y > target.y and b.y < target.y + target.h and target.hits > 0 then
             
            return true,i
        end
    end
end
