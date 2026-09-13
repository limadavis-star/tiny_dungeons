local Concord = require("libraries.concord")

require("src.components.position")
require("src.components.animation")
require("src.components.velocity")
require("src.components.speed")
require("src.components.controllable")
require("src.components.collider")
require("src.entities.room")
require("src.components.room")


local Player = require("src.entities.player")
local Room = require("src.entities.room")


local AnimationSystem = require("src.systems.animation_system")
local AnimationRenderSystem = require("src.systems.animation_render_system")
local InputSystem = require("src.systems.input_system")
local PlayerAnimationSystem = require("src.systems.player_animation_system")
local PhysicsWorld = require("src.physics.physics_world")
local PhysicsSystem = require("src.systems.physics_system")
local RoomRenderSystem = require("src.systems.room_render_system")

local Gameplay = {}

function Gameplay:enter()
    self.ecsWorld = Concord.world()
    self.physicWorld = PhysicsWorld.create()

    self.room = Room.create(self.ecsWorld, 160, 96, 1040, 576)

    self.ecsWorld:addSystems(
        InputSystem,
        PhysicsSystem,
        PlayerAnimationSystem,
        AnimationSystem,
        RoomRenderSystem,
        AnimationRenderSystem
    )


    self.player = Player.create(self.ecsWorld,
        self.physicWorld,
        love.graphics.getWidth() / 2,
        love.graphics.getHeight() / 2)

    self.physicsSystem =
        self.ecsWorld:getSystem(PhysicsSystem)

    self.physicsSystem:setWorld(
        self.physicWorld
    )


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

    love.graphics.print(
        "Player X: " .. math.floor(self.player.position.x),
        32,
        92
    )

    love.graphics.print(
        "Player Y: " .. math.floor(self.player.position.y),
        32,
        112
    )

    love.graphics.print(
        "Physics pool: "
        .. #self.physicsSystem.pool,
        32,
        132
    )


    local physicsVelocityX,
    physicsVelocityY =
        self.player.collider.body.body:getLinearVelocity()

    love.graphics.print(
        "Physics velocity: "
        .. math.floor(physicsVelocityX)
        .. ", "
        .. math.floor(physicsVelocityY),
        32,
        172
    )
end

return Gameplay
