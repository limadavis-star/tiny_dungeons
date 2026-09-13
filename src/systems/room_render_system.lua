local Concord = require("libraries.concord")

local RoomRenderSystem = Concord.system({
    pool = {
        "position",
        "room",
    },
})

function RoomRenderSystem:draw()
    for _, entity in ipairs(self.pool) do
        local position = entity.position
        local room = entity.room

        love.graphics.setColor(0.08, 0.12, 0.22, 1)
        love.graphics.rectangle(
            "fill",
            position.x,
            position.y,
            room.width,
            room.height
        )

        local doorWidth = 96
        local doorLeft = position.x + (room.width - doorWidth) / 2
        local doorRight = doorLeft + doorWidth

        local left = position.x
        local right = position.x + room.width
        local top = position.y
        local bottom = position.y + room.height

        love.graphics.setColor(0.55, 0.75, 0.95, 1)
        love.graphics.setLineWidth(8)

        love.graphics.line(left, top, doorLeft, top)
        love.graphics.line(doorRight, top, right, top)
        love.graphics.line(left, bottom, right, bottom)
        love.graphics.line(left, top, left, bottom)
        love.graphics.line(right, top, right, bottom)
    end

    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)
end

return RoomRenderSystem
