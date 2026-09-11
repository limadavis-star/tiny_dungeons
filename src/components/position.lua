local Concord = require("libraries.concord")

local Position = Concord.component("position", function(component, x, y)
    component.x = x or 0
    component.y = y or 0
end
)

return Position
