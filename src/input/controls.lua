local baton = require("libraries.baton.baton")

local controls = baton.new({
    controls = {
        left = {
            "key:a",
            "key:left",
        },

        right = {
            "key:d",
            "key:right",
        },

        up = {
            "key:w",
            "key:up",
        },

        down = {
            "key:s",
            "key:down",
        },


    },

    pairs = {
        move = { "left", "right", "up", "down" }
    }
})

return controls
