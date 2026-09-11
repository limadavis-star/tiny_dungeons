local Concord = require("libraries.concord")

local Animation = Concord.component(
    "animation",
    function(component, image, animations, initialDirection)
        component.image = image
        component.animations = animations

        component.direction = initialDirection or "down"
        component.current = animations[component.direction]
    end

)

return Animation
