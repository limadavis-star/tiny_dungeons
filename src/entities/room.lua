local Concord = require("libraries.concord")

local Room = {}

function Room.create(ecsWorld, x, y, width, height, doorWidth, doorSide)
    return Concord.entity(ecsWorld)
        :give("position", x, y)
        :give("room", width, height, doorWidth, doorSide)
end

return Room
