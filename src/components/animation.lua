local Concord = require("libraries.concord")

local Animation = Concord.component(
    "animation",
    function(component, image, current)
        component.image = image
        component.current = current
    end

)

return Animation
