local Concord = require("libraries.concord")
local controls = require("src.input.controls")

require("src.components.position")
require("src.components.animation")
require("src.components.velocity")
require("src.components.speed")
require("src.components.controllabe")

local Player = require("src.entities.player")


local AnimationSystem = require("src.systems.animation_system")
local AnimationRenderSystem = require("src.systems.animation_render_system")

local Gameplay = {}

function Gameplay:enter()
    self.ecsWorld = Concord.world()
    self.ecsWorld:addSystems(
        AnimationSystem,
        AnimationRenderSystem
    )
    self.player = Player.create(self.ecsWorld,
        love.graphics.getWidth() / 2,
        love.graphics.getHeight() / 2)


    self.moveX = 0
    self.moveY = 0
end

function Gameplay:update(dt)
    controls:update()
    self.moveX, self.moveY = controls:get("move")


    self.ecsWorld:emit("update", dt)
end

function Gameplay:draw()
    self.ecsWorld:emit("draw")
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Tiny Dungeons", 32, 32)

    love.graphics.print(
        "Movement X: " .. self.moveX,
        32,
        52
    )

    love.graphics.print(
        "Movement Y: " .. self.moveY,
        32,
        72
    )
end

return Gameplay
