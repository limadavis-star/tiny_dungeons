local Concord = require("libraries.concord")
local anim8 = require("libraries.anim8.anim8")
local breezefield = require("libraries.breezefield")

local Player = {}

function Player.create(ecsWorld, physicWorld, x, y)
    local image = love.graphics.newImage("assets/images/player/ninja-green/walk.png")


    local grid = anim8.newGrid(16, 16, image:getWidth(), image:getHeight())

    local walkAnimation = anim8.newAnimation(
        grid(1, "1-4"),
        0.15
    )

    local playerCollider = breezefield.Collider.new(physicWorld, "Circle", x, y, 6)

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
            walkAnimation
        )

    return entity
end

return Player
