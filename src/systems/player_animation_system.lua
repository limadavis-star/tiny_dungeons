local Concord = require("libraries.concord")

local PlayerAnimationSystem = Concord.system({
    pool = {
        "controllable",
        "velocity",
        "animation",
    },
})

local function getMovementDirection(velocity)
    local horizontalSpeed =
        math.abs(velocity.x)

    local verticalSpeed =
        math.abs(velocity.y)

    if horizontalSpeed >= verticalSpeed then
        if velocity.x > 0 then
            return "right"
        end

        return "left"
    end

    if velocity.y > 0 then
        return "down"
    end

    return "up"
end

local function changeDirection(
    animationComponent,
    newDirection
)
    if animationComponent.direction
        == newDirection then
        return
    end

    animationComponent.current:pause()
    animationComponent.current:gotoFrame(1)

    animationComponent.direction =
        newDirection

    animationComponent.current =
        animationComponent.animations[
        newDirection
        ]

    animationComponent.current:gotoFrame(1)
end

function PlayerAnimationSystem:update()
    for _, entity in ipairs(self.pool) do
        local velocity = entity.velocity
        local animation = entity.animation

        local isMoving =
            velocity.x ~= 0
            or velocity.y ~= 0

        if isMoving then
            local direction =
                getMovementDirection(velocity)

            changeDirection(
                animation,
                direction
            )

            animation.current:resume()
        else
            animation.current:pause()
            animation.current:gotoFrame(1)
        end
    end
end

return PlayerAnimationSystem
