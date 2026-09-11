local Concord = require("libraries.concord")

local AnimationRenderSystem = Concord.system({
    pool = {
        "position",
        "animation"
    }
})

function AnimationRenderSystem:draw()
    love.graphics.setColor(1, 1, 1, 1)

    for _, entity in ipairs(self.pool) do
        local position = entity.position
        local animation = entity.animation

        animation.current:draw(
            animation.image,
            position.x,
            position.y,
            0,
            4,
            4,
            8,
            8
        )
    end
end

return AnimationRenderSystem
