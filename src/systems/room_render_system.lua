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

        local left = position.x
        local right = position.x + room.width
        local top = position.y
        local bottom = position.y + room.height

        local doorLeft = left + (room.width - room.doorWidth) / 2
        local doorRight = doorLeft + room.doorWidth

        love.graphics.setColor(0.55, 0.75, 0.95, 1)
        love.graphics.setLineWidth(8)

        if room.doors.top then
            love.graphics.line(left, top, doorLeft, top)
            love.graphics.line(doorRight, top, right, top)
        else
            love.graphics.line(left, top, right, top)
        end

        if room.doors.bottom then
            love.graphics.line(left, bottom, doorLeft, bottom)
            love.graphics.line(doorRight, bottom, right, bottom)
        else
            love.graphics.line(left, bottom, right, bottom)
        end

        if room.doors.left then
            local doorTop = top + (room.height - room.doorWidth) / 2
            local doorBottom = doorTop + room.doorWidth

            love.graphics.line(left, top, left, doorTop)
            love.graphics.line(left, doorBottom, left, bottom)
        else
            love.graphics.line(left, top, left, bottom)
        end
        if room.doors.right then
            local doorTop =
                top + (room.height - room.doorWidth) / 2

            local doorBottom =
                doorTop + room.doorWidth

            love.graphics.line(right, top, right, doorTop)
            love.graphics.line(right, doorBottom, right, bottom)
        else
            love.graphics.line(right, top, right, bottom)
        end
    end

    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)
end

return RoomRenderSystem
