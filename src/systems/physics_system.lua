local Concord = require("libraries.concord")

local PhysicsSystem = Concord.system({
    pool = {
        "position",
        "velocity",
        "collider"
    }
})

function PhysicsSystem:setWorld(physicsWorld)
    self.physicsWorld = physicsWorld
end

function PhysicsSystem:update(dt)
    if not self.physicsWorld then
        return
    end

    for _, entity in ipairs(self.pool) do
        local velocity = entity.velocity
        local collider = entity.collider.body

        collider:setLinearVelocity(velocity.x, velocity.y)
    end

    self.physicsWorld:update(dt)

    for _, entity in ipairs(self.pool) do
        local collider = entity.collider.body

        entity.position.x, entity.position.y = collider:getPosition()
    end
end

return PhysicsSystem
