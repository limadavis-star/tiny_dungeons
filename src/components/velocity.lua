local Concord = require("libraries.concord")

local Velocity = Concord.component(
    "velocity",
    function(component, x, y)
        component.x = x or 0
        component.y = y or 0
    end
)

return Velocity
