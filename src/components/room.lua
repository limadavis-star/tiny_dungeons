local Concord = require("libraries.concord")

local Room = Concord.component(
    "room",
    function(component, width, height, doorWidth, doorSide)
        component.width = width
        component.height = height
        component.doorWidth = doorWidth
        component.doorSide = doorSide
    end
)

return Room
