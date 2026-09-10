local baton = require("libraries.baton.baton")

local controls = baton.new({
    controls = {
        left = {
            "key:a",
            "key:left",
            "axis:leftx-",
            "button:dpleft",
        },

        right = {
            "key:d",
            "key:right",
            "axis:leftx+",
            "button:dpright",
        },

        up = {
            "key:w",
            "key:up",
            "axis:lefty-",
            "button:dpup",
        },

        down = {
            "key:s",
            "key:down",
            "axis:lefty+",
            "button:dpdown",
        },
    },

    pairs = {
        move = {
            "left",
            "right",
            "up",
            "down",
        },
    },

    joystick = love.joystick.getJoysticks()[1],
    deadzone = 0.15,
})

return controls
