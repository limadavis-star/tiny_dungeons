local RoomTransition = {}

local function roomCenter(roomEntity)
    return
        roomEntity.position.x + roomEntity.room.width / 2,
        roomEntity.position.y + roomEntity.room.height / 2
end

local function findRoom(rooms, x, y)
    for _, roomEntity in ipairs(rooms) do
        local left = roomEntity.position.x
        local top = roomEntity.position.y
        local right = left + roomEntity.room.width
        local bottom = top + roomEntity.room.height

        if x >= left and x < right
            and y >= top and y < bottom then
            return roomEntity
        end
    end

    return nil
end

function RoomTransition.create(camera, player, rooms)
    local startingRoom = rooms[1]
    local centerX, centerY = roomCenter(startingRoom)

    camera:lookAt(centerX, centerY)

    return {
        camera = camera,
        player = player,
        rooms = rooms,
        activeRoom = startingRoom,
        transition = nil,
    }
end

function RoomTransition.update(state, dt)
    if state.transition then
        local transition = state.transition

        transition.elapsed = math.min(
            transition.elapsed + dt,
            transition.duration
        )

        local progress = transition.elapsed / transition.duration
        local smoothProgress = progress * progress * (3 - 2 * progress)

        state.camera:lookAt(
            transition.fromX
            + (transition.toX - transition.fromX) * smoothProgress,
            transition.fromY
            + (transition.toY - transition.fromY) * smoothProgress
        )

        if progress >= 1 then
            state.activeRoom = transition.toRoom
            state.transition = nil
            state.player:give("controllable")
        end

        return
    end

    local nextRoom = findRoom(
        state.rooms,
        state.player.position.x,
        state.player.position.y
    ) or state.activeRoom

    if nextRoom == state.activeRoom then
        return
    end

    state.player.velocity.x = 0
    state.player.velocity.y = 0
    state.player:remove("controllable")

    local fromX, fromY = roomCenter(state.activeRoom)
    local toX, toY = roomCenter(nextRoom)

    state.transition = {
        fromX = fromX,
        fromY = fromY,
        toX = toX,
        toY = toY,
        toRoom = nextRoom,
        elapsed = 0,
        duration = 0.45,
    }
end

return RoomTransition
