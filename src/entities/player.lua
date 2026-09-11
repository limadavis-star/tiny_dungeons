local Concord = require("libraries.concord")
local anim8 = require("libraries.anim8.anim8")

local Player = {}

function Player.create(world, x, y)
    local image = love.graphics.newImage("assets/images/player/ninja-green/idle.png")


    local grid = anim8.newGrid(16, 16, image:getWidth(), image:getHeight())

    local idleAnimation = anim8.newAnimation(
        grid(1, 1),
        0.15
    )

    local entity = Concord.entity(world)
        :give("position", x, y)
        :give("velocity", 0, 0)
        :give("speed", 150)
        :give("controllable")
        :give(
            "animation",
            image,
            idleAnimation
        )

    return entity
end

return Player
