local Concord = require("libraries.concord")

local Room = Concord.component(
    "room",
    function(component, width, height, doorWidth)
        component.width = width
        component.height = height
        component.doorWidth = doorWidth
    end
)

return Room
