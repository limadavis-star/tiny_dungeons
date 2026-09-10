function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0.02, 0.04, 0.10)
end

function love.update(dt)
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Tiny Dungeons", 32, 32)
end
