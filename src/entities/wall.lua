local Concord = require("libraries.concord")
local breezefield = require("libraries.breezefield")

local Wall = {}



function Wall.create(ecsWorld, physics_world, x, y, width, height)
    local left = x
    local right = x + width
    local top = y
    local bottom = y + height

    local collider = breezefield.Collider.new(
        physics_world,
        "Polygon", {
            left, top,
            right, top,
            right, bottom,
            left, bottom,

        }
    )

    collider:setType("static")

    return Concord.entity(ecsWorld)
        :give("wall")
        :give("collider", collider)
end

return Wall
