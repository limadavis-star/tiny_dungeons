local Concord = require("libraries.concord")

local AnimationSystem = Concord.system({
    pool = {
        "animation",
    }
})

function AnimationSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        entity.animation.current:update(dt)
    end
end

return AnimationSystem
