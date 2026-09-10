local roomy = require("libraries.roomy.roomy")
local Gameplay = require("src.states.gameplay")

local sceneManager = roomy.new()

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0.02, 0.04, 0.10)

    sceneManager:hook()
    sceneManager:enter(Gameplay)
end
