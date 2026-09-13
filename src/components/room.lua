local Concord = require("libraries.concord")

local Room = Concord.component(
    "room",
    function(component, width, height, doorWidth, doors, isGoal)
        component.width = width
        component.height = height
        component.doorWidth = doorWidth
        component.doors = doors
        component.isGoal = isGoal or false
    end
)

return Room
