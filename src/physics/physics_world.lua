local breezefield = require("libraries.breezefield")

local PhysicWorld = {}

function PhysicWorld.create()
    return breezefield.newWorld(0, 0, true)
end

return PhysicWorld
