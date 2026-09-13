local Concord = require("libraries.concord")

local Room = Concord.component(
    "room",
    function(component, width, height, doorWidth, doors)
        component.width = width
        component.height = height
        component.doorWidth = doorWidth
        component.doors = doors
    end
)

return Room
