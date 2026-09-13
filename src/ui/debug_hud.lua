local DebugHud = {}

function DebugHud.draw(player, physicsSystem)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.print("Tiny Dungeons", 32, 32)
    love.graphics.print("Velocity X: " .. player.velocity.x, 32, 52)
    love.graphics.print("Velocity Y: " .. player.velocity.y, 32, 72)

    love.graphics.print(
        "Player X: " .. math.floor(player.position.x),
        32,
        92
    )

    love.graphics.print(
        "Player Y: " .. math.floor(player.position.y),
        32,
        112
    )

    love.graphics.print(
        "Physics pool: " .. #physicsSystem.pool,
        32,
        132
    )

    local velocityX, velocityY =
        player.collider.body.body:getLinearVelocity()

    love.graphics.print(
        "Physics velocity: "
        .. math.floor(velocityX)
        .. ", "
        .. math.floor(velocityY),
        32,
        172
    )
end

return DebugHud
