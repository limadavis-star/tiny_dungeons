local Concord = require("libraries.concord")

local Room = {}

function Room.create(ecsWorld, x, y, width, height)
    return Concord.entity(ecsWorld)
        :give("position", x, y)
        :give("room", width, height)
end

return Room
