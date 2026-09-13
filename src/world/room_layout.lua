local RoomLayout = {}

local ROOM_WIDTH = 1040
local ROOM_HEIGHT = 576
local DOOR_WIDTH = 96
local ROOM_COUNT = 6
local GRID_LIMIT = 2

local DIRECTIONS = {
    { dx = 0,  dy = -1, door = "top",    opposite = "bottom" },
    { dx = 1,  dy = 0,  door = "right",  opposite = "left" },
    { dx = 0,  dy = 1,  door = "bottom", opposite = "top" },
    { dx = -1, dy = 0,  door = "left",   opposite = "right" },
}

local function positionKey(gridX, gridY)
    return gridX .. ":" .. gridY
end

local function makeRoom(gridX, gridY)
    return {
        gridX = gridX,
        gridY = gridY,
        x = 160 + gridX * ROOM_WIDTH,
        y = 96 + gridY * ROOM_HEIGHT,
        width = ROOM_WIDTH,
        height = ROOM_HEIGHT,
        doorWidth = DOOR_WIDTH,
        doors = {},
    }
end

function RoomLayout.create()
    local startingRoom = makeRoom(0, 0)
    local rooms = { startingRoom }

    local occupied = {
        [positionKey(0, 0)] = startingRoom,
    }

    for _ = 2, ROOM_COUNT do
        local candidates = {}

        for _, room in ipairs(rooms) do
            for _, direction in ipairs(DIRECTIONS) do
                local nextX = room.gridX + direction.dx
                local nextY = room.gridY + direction.dy

                local insideGrid =
                    math.abs(nextX) <= GRID_LIMIT
                    and math.abs(nextY) <= GRID_LIMIT

                if insideGrid
                    and not occupied[positionKey(nextX, nextY)] then
                    candidates[#candidates + 1] = {
                        from = room,
                        gridX = nextX,
                        gridY = nextY,
                        direction = direction,
                    }
                end
            end
        end

        local chosen = candidates[love.math.random(#candidates)]
        local newRoom = makeRoom(chosen.gridX, chosen.gridY)

        chosen.from.doors[chosen.direction.door] = true
        newRoom.doors[chosen.direction.opposite] = true

        rooms[#rooms + 1] = newRoom
        occupied[positionKey(chosen.gridX, chosen.gridY)] = newRoom
    end

    return rooms
end

return RoomLayout
