local Concord = require("libraries.concord")

local PlayerAnimationSystem = Concord.system({
    pool = {
        "controllable",
        "velocity",
        "animation"
    }
})


function PlayerAnimationSystem:update()
    for _, entity in ipairs(self.pool) do
        local velocity = entity.velocity
        local animation = entity.animation.current

        local isMoving = velocity.x ~= 0
            or velocity.y ~= 0

        if isMoving then
            animation:resume()
        else
            animation:pause()
            animation:gotoFrame(1)
        end
    end
end

return PlayerAnimationSystem
