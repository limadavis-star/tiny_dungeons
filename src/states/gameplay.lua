local Concord = require("libraries.concord")
local Camera = require("libraries.hump.camera")

require("src.components.position")
require("src.components.animation")
require("src.components.velocity")
require("src.components.speed")
require("src.components.controllable")
require("src.components.collider")
require("src.components.room")
require("src.components.wall")


local Player = require("src.entities.player")
local Room = require("src.entities.room")
local RoomWallBuilder = require("src.physics.room_wall_builder")
local RoomTransition = require("src.graphics.room_transition")
local RoomLayout = require("src.world.room_layout")

local AnimationSystem = require("src.systems.animation_system")
local AnimationRenderSystem = require("src.systems.animation_render_system")
local InputSystem = require("src.systems.input_system")
local PlayerAnimationSystem = require("src.systems.player_animation_system")
local PhysicsWorld = require("src.physics.physics_world")
local PhysicsSystem = require("src.systems.physics_system")
local RoomRenderSystem = require("src.systems.room_render_system")
local DebugHud = require("src.ui.debug_hud")

local Gameplay = {}

local function createRoom(ecsWorld, data)
    return Room.create(
        ecsWorld,
        data.x,
        data.y,
        data.width,
        data.height,
        data.doorWidth,
        data.doors
    )
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

    local layout = RoomLayout.create()

    self.room = createRoom(self.ecsWorld, layout.start)
    self.upperRoom = createRoom(self.ecsWorld, layout.upper)
    self.rightRoom = createRoom(self.ecsWorld, layout.right)
    self.bottomRoom = createRoom(self.ecsWorld, layout.lower)

    self.player = Player.create(self.ecsWorld,
        self.physicWorld,
        love.graphics.getWidth() / 2,
        love.graphics.getHeight() / 2)


    RoomWallBuilder.create(
        self.ecsWorld,
        self.physicWorld,
        self.room,
        self.upperRoom,
        self.rightRoom,
        self.bottomRoom
    )

    self.camera = Camera(
        self.player.position.x,
        self.player.position.y
    )
    self.roomTransition = RoomTransition.create(
        self.camera,
        self.player,
        {
            self.room,
            self.upperRoom,
            self.rightRoom,
            self.bottomRoom,
        }
    )

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
    RoomTransition.update(self.roomTransition, dt)
end

function Gameplay:draw()
    self.camera:attach()
    self.ecsWorld:emit("draw")
    self.camera:detach()





    DebugHud.draw(self.player, self.physicsSystem)
end

return Gameplay
