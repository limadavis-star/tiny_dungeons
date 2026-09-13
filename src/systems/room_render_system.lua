local Concord = require("libraries.concord")

local RoomRenderSystem = Concord.system({
    pool = {
        "position",
        "room",
    },
})

function RoomRenderSystem:draw()
    love.graphics.setColor(0.08, 0.12, 0.22, 1)

    for _, entity in ipairs(self.pool) do
        love.graphics.rectangle(
            "fill",
            entity.position.x,
            entity.position.y,
            entity.room.width,
            entity.room.height
        )
    end

    love.graphics.setColor(1, 1, 1, 1)
end

return RoomRenderSystem
