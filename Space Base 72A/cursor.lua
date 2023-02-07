function drawCursor()
    
    local cursorImg = love.graphics.newImage('assets/cursor.png')
    local cursor = love.mouse.newCursor('assets/cursor.png', cursorImg:getWidth()/2, cursorImg:getHeight()/2 )
    love.mouse.setCursor(cursor)

end

