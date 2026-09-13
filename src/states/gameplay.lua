local Concord = require("libraries.concord")
local Camera = require("libraries.hump.camera")

require("src.components.position")
require("src.components.animation")
require("src.components.velocity")
require("src.components.speed")
require("src.components.controllable")
require("src.components.collider")
require("src.entities.room")
require("src.components.room")
require("src.components.wall")


local Player = require("src.entities.player")
local Room = require("src.entities.room")
local RoomWallBuilder = require("src.physics.room_wall_builder")


local AnimationSystem = require("src.systems.animation_system")
local AnimationRenderSystem = require("src.systems.animation_render_system")
local InputSystem = require("src.systems.input_system")
local PlayerAnimationSystem = require("src.systems.player_animation_system")
local PhysicsWorld = require("src.physics.physics_world")
local PhysicsSystem = require("src.systems.physics_system")
local RoomRenderSystem = require("src.systems.room_render_system")

local Gameplay = {}

local function roomCenter(roomEntity)
    return
        roomEntity.position.x + roomEntity.room.width / 2,
        roomEntity.position.y + roomEntity.room.height / 2
end

function Gameplay:enter()
    self.ecsWorld = Concord.world()
    self.physicWorld = PhysicsWorld.create()

    self.ecsWorld:addSystems(
        InputSystem,
        PlayerAnimationSystem,
        AnimationSystem,
        PhysicsSystem,
        RoomRenderSystem,
        AnimationRenderSystem
    )

    self.room = Room.create(
        self.ecsWorld, 160, 96, 1040, 576, 96, "top"
    )

    self.upperRoom = Room.create(
        self.ecsWorld, 160, -480, 1040, 576, 96, "bottom"
    )

    self.player = Player.create(self.ecsWorld,
        self.physicWorld,
        love.graphics.getWidth() / 2,
        love.graphics.getHeight() / 2)

    RoomWallBuilder.create(
        self.ecsWorld,
        self.physicWorld,
        self.room,
        self.upperRoom
    )

    self.activeRoom = self.room
    self.transition = nil
    self.camera = Camera(roomCenter(self.activeRoom))

    self.camera = Camera(roomCenter(self.activeRoom))

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

    if self.transition then
        local transition = self.transition

        transition.elapsed = math.min(
            transition.elapsed + dt,
            transition.duration
        )

        local progress = transition.elapsed / transition.duration
        local smoothProgress = progress * progress * (3 - 2 * progress)

        self.camera:lookAt(
            transition.fromX
            + (transition.toX - transition.fromX) * smoothProgress,
            transition.fromY
            + (transition.toY - transition.fromY) * smoothProgress
        )

        if progress >= 1 then
            self.activeRoom = transition.toRoom
            self.transition = nil
            self.player:give("controllable")
        end

        return
    end

    local nextRoom = self.room

    if self.player.position.y < self.room.position.y then
        nextRoom = self.upperRoom
    end

    if nextRoom ~= self.activeRoom then
        self.player.velocity.x = 0
        self.player.velocity.y = 0
        self.player:remove("controllable")

        local fromX, fromY = roomCenter(self.activeRoom)
        local toX, toY = roomCenter(nextRoom)

        self.transition = {
            fromX = fromX,
            fromY = fromY,
            toX = toX,
            toY = toY,
            toRoom = nextRoom,
            elapsed = 0,
            duration = 0.45,
        }
    end
end

function Gameplay:draw()
    self.camera:attach()
    self.ecsWorld:emit("draw")
    self.camera:detach()

    love.graphics.setColor(1, 1, 1, 1)
    self.camera:attach()
    self.ecsWorld:emit("draw")
    self.camera:detach()
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
