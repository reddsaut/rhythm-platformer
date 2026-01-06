class = require "lib.30log"
Tiny = require "lib.tiny"

local Player = require("src.entities.Player")
local Light = require("src.entities.Light")
local BeatDisplay = require("src.entities.BeatDisplay")

local conductor = require("src.systems.Conductor")
local drawSystem = require("src.systems.DrawSystem")
local playerControlSystem = require("src.systems.PlayerControlSystem")

local world = Tiny.world(
    conductor,
    drawSystem,
    playerControlSystem,
    Player(100,100),
    Light(50,50,2,{0}),
    Light(100,50,4,{2}),
    BeatDisplay(500,50,4)
)

function love.load()

end

function love.draw()
    local dt = love.timer.getDelta()
    world:update(dt)
end

function love.update(dt)
end