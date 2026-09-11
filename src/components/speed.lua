local Concord = require("libraries.concord")

local Speed = Concord.component(
    "speed",
    function(component, value)
        component.value = value or 100
    end
)

return Speed
