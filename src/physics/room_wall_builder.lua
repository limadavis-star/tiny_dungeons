local Wall = require("src.entities.wall")

local RoomWallBuilder = {}

local THICKNESS = 8

local function positionKey(x, y)
    return x .. ":" .. y
end

local function horizontalWall(
    ecsWorld, physicWorld, left, right, y, doorLeft, doorRight
)
    if doorLeft then
        Wall.create(
            ecsWorld, physicWorld,
            left, y, doorLeft - left, THICKNESS
        )

        Wall.create(
            ecsWorld, physicWorld,
            doorRight, y, right - doorRight, THICKNESS
        )
    else
        Wall.create(
            ecsWorld, physicWorld,
            left, y, right - left, THICKNESS
        )
    end
end

local function verticalWall(
    ecsWorld, physicWorld, x, top, bottom, doorTop, doorBottom
)
    if doorTop then
        Wall.create(
            ecsWorld, physicWorld,
            x, top, THICKNESS, doorTop - top
        )

        Wall.create(
            ecsWorld, physicWorld,
            x, doorBottom, THICKNESS, bottom - doorBottom
        )
    else
        Wall.create(
            ecsWorld, physicWorld,
            x, top, THICKNESS, bottom - top
        )
    end
end

function RoomWallBuilder.create(ecsWorld, physicWorld, rooms)
    local roomsByPosition = {}

    for _, roomEntity in ipairs(rooms) do
        roomsByPosition[positionKey(
            roomEntity.position.x,
            roomEntity.position.y
        )] = roomEntity
    end

    for _, roomEntity in ipairs(rooms) do
        local x = roomEntity.position.x
        local y = roomEntity.position.y
        local room = roomEntity.room

        local horizontalLeft = x + THICKNESS / 2
        local horizontalRight = x + room.width - THICKNESS / 2
        local verticalTop = y + THICKNESS / 2
        local verticalBottom = y + room.height - THICKNESS / 2

        local doorLeft = x + (room.width - room.doorWidth) / 2
        local doorRight = doorLeft + room.doorWidth
        local doorTop = y + (room.height - room.doorWidth) / 2
        local doorBottom = doorTop + room.doorWidth

        horizontalWall(
            ecsWorld, physicWorld,
            horizontalLeft, horizontalRight,
            y - THICKNESS / 2,
            room.doors.top and doorLeft or nil,
            room.doors.top and doorRight or nil
        )

        verticalWall(
            ecsWorld, physicWorld,
            x + room.width - THICKNESS / 2,
            verticalTop, verticalBottom,
            room.doors.right and doorTop or nil,
            room.doors.right and doorBottom or nil
        )

        local hasRoomBelow = roomsByPosition[positionKey(
            x,
            y + room.height
        )] ~= nil

        if not hasRoomBelow then
            horizontalWall(
                ecsWorld, physicWorld,
                horizontalLeft, horizontalRight,
                y + room.height - THICKNESS / 2,
                room.doors.bottom and doorLeft or nil,
                room.doors.bottom and doorRight or nil
            )
        end

        local hasRoomToLeft = roomsByPosition[positionKey(
            x - room.width,
            y
        )] ~= nil

        if not hasRoomToLeft then
            verticalWall(
                ecsWorld, physicWorld,
                x - THICKNESS / 2,
                verticalTop, verticalBottom,
                room.doors.left and doorTop or nil,
                room.doors.left and doorBottom or nil
            )
        end
    end
end

return RoomWallBuilder
