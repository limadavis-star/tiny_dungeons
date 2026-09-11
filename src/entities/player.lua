local Concord = require("libraries.concord")
local anim8 = require("libraries.anim8.anim8")
local breezefield = require("libraries.breezefield")

local Player = {}

function Player.create(ecsWorld, physicWorld, x, y)
    local image = love.graphics.newImage("assets/images/player/ninja-green/walk.png")


    local grid = anim8.newGrid(16, 16, image:getWidth(), image:getHeight())

    local animations = {
        down = anim8.newAnimation(
            grid(1, "1-4"),
            0.15
        ),

        up = anim8.newAnimation(
            grid(2, "1-4"),
            0.15
        ),

        left = anim8.newAnimation(
            grid(3, "1-4"),
            0.15
        ),

        right = anim8.newAnimation(
            grid(4, "1-4"),
            0.15
        ),
    }

    local playerCollider = breezefield.Collider.new(physicWorld, "Circle", x, y, 6)

    playerCollider:setType("dynamic")
    playerCollider:setFixedRotation(true)


    local entity = Concord.entity(ecsWorld)
        :give("position", x, y)
        :give("velocity", 0, 0)
        :give("speed", 150)
        :give("controllable")
        :give("collider", playerCollider)
        :give(
            "animation",
            image,
            animations
        )

    return entity
end

return Player
