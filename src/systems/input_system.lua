local Concord = require("libraries.concord")
local controls = require("src.input.controls")

local InputSystem = Concord.system({
    pool = {
        "controllable",
        "velocity",
        "speed"
    }
})

function InputSystem:update()
    controls:update()

    local moveX, moveY = controls:get("move")

    for _, entity in ipairs(self.pool) do
        entity.velocity.x = moveX * entity.speed.value
        entity.velocity.y = moveY * entity.speed.value
    end
end

return InputSystem
