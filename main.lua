class = require "lib.30log"
Tiny = require "lib.tiny"

local Player = require("src.entities.Player")
local Light = require("src.entities.Light")

local DrawSystem = require("src.systems.DrawSystem")
local PlayerControlSystem = require("src.systems.PlayerControlSystem")

local world = Tiny.world(
    DrawSystem,
    PlayerControlSystem,
    Player(100,100),
    Light(50,50),
    Light(100,50)
)

function love.load()

end

function love.draw()
    local dt = love.timer.getDelta()
    world:update(dt)
end

function love.update(dt)
end