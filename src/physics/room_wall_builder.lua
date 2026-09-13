local Wall = require("src.entities.wall")

local RoomWallBuilder = {}

function RoomWallBuilder.create(ecsWorld, physicWorld, lowerRoom, upperRoom)
    local x = lowerRoom.position.x
    local y = lowerRoom.position.y
    local width = lowerRoom.room.width
    local height = lowerRoom.room.height
    local doorWidth = lowerRoom.room.doorWidth
    local thickness = 8

    local doorLeft = x + (width - doorWidth) / 2
    local doorRight = doorLeft + doorWidth
    local outerLeft = x - thickness / 2
    local outerRight = x + width + thickness / 2

    Wall.create(
        ecsWorld, physicWorld,
        outerLeft, y - thickness / 2,
        doorLeft - outerLeft, thickness
    )

    Wall.create(
        ecsWorld, physicWorld,
        doorRight, y - thickness / 2,
        outerRight - doorRight, thickness
    )

    Wall.create(
        ecsWorld, physicWorld,
        outerLeft, y + height - thickness / 2,
        width + thickness, thickness
    )

    Wall.create(
        ecsWorld, physicWorld,
        x - thickness / 2, y + thickness / 2,
        thickness, height - thickness
    )

    Wall.create(
        ecsWorld, physicWorld,
        x + width - thickness / 2, y + thickness / 2,
        thickness, height - thickness
    )

    local upperY = upperRoom.position.y
    local upperHeight = upperRoom.room.height

    Wall.create(
        ecsWorld, physicWorld,
        outerLeft, upperY - thickness / 2,
        width + thickness, thickness
    )

    Wall.create(
        ecsWorld, physicWorld,
        x - thickness / 2, upperY + thickness / 2,
        thickness, upperHeight - thickness
    )

    Wall.create(
        ecsWorld, physicWorld,
        x + width - thickness / 2, upperY + thickness / 2,
        thickness, upperHeight - thickness
    )
end

return RoomWallBuilder
