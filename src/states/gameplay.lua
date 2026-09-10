local Concord = require("libraries.concord")

local Gameplay = {}

function Gameplay:enter()
    self.ecsWorld = Concord.world()
end

function Gameplay:update(dt)
    self.ecsWorld:emit("update", dt)
end

function Gameplay:draw()
    self.ecsWorld:emit("draw")
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Tiny Dungeons", 32, 32)
end

return Gameplay
