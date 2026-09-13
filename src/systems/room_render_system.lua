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
        local position = entity.position
        local room = entity.room

        love.graphics.rectangle(
            "fill",
            position.x,
            position.y,
            room.width,
            room.height
        )

        love.graphics.setColor(0.34, 0.48, 0.65, 1)
        love.graphics.setLineWidth(8)
        love.graphics.rectangle("line", position.x, position.y, room.width, room.height)
    end


    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)
end

return RoomRenderSystem
