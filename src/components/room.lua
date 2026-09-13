local Concord = require("libraries.concord")

local Room = Concord.component(
    "room",
    function(component, width, height)
        component.width = width
        component.height = height
    end
)

return Room
