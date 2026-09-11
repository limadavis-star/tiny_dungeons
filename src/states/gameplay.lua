local Concord = require("libraries.concord")

require("src.components.position")
require("src.components.animation")
require("src.components.velocity")
require("src.components.speed")
require("src.components.controllable")

local Player = require("src.entities.player")


local AnimationSystem = require("src.systems.animation_system")
local AnimationRenderSystem = require("src.systems.animation_render_system")
local InputSystem = require("src.systems.input_system")
local PlayerAnimationSystem = require("src.systems.player_animation_system")

local Gameplay = {}

function Gameplay:enter()
    self.ecsWorld = Concord.world()

    self.ecsWorld:addSystems(
        InputSystem,
        PlayerAnimationSystem,
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
    self.ecsWorld:emit("update", dt)
end

function Gameplay:draw()
    self.ecsWorld:emit("draw")
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Tiny Dungeons", 32, 32)

    love.graphics.print(
        "Velocity X: " .. self.player.velocity.x,
        32,
        52
    )

    love.graphics.print(
        "Velocity Y: " .. self.player.velocity.y,
        32,
        72
    )
end

return Gameplay
