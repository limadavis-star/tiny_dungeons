local RoomLayout = {}

function RoomLayout.create()
    local x = 160
    local y = 96
    local width = 1040
    local height = 576
    local doorWidth = 96

    return {
        start = {
            x = x,
            y = y,
            width = width,
            height = height,
            doorWidth = doorWidth,
            doors = {
                top = true,
                right = true,
                bottom = true,
            },
        },

        upper = {
            x = x,
            y = y - height,
            width = width,
            height = height,
            doorWidth = doorWidth,
            doors = { bottom = true },
        },

        right = {
            x = x + width,
            y = y,
            width = width,
            height = height,
            doorWidth = doorWidth,
            doors = { left = true },
        },
        lower = {
            x = x,
            y = y + height,
            width = width,
            height = height,
            doorWidth = doorWidth,
            doors = { top = true },
        },
    }
end

return RoomLayout
