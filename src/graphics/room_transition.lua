local RoomTransition = {}

local function roomCenter(roomEntity)
    return
        roomEntity.position.x + roomEntity.room.width / 2,
        roomEntity.position.y + roomEntity.room.height / 2
end

function RoomTransition.create(camera, player, lowerRoom, upperRoom)
    local centerX, centerY = roomCenter(lowerRoom)
    camera:lookAt(centerX, centerY)

    return {
        camera = camera,
        player = player,
        lowerRoom = lowerRoom,
        upperRoom = upperRoom,
        activeRoom = lowerRoom,
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

    local nextRoom = state.lowerRoom

    if state.player.position.y < state.lowerRoom.position.y then
        nextRoom = state.upperRoom
    end

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
