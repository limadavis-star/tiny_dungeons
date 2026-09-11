local Concord = require("libraries.concord")

local Collider = Concord.component(
    "collider",
    function(component, body)
        component.body = body
    end
)

return Collider
