class = require "lib.30log"
Tiny = require "lib.tiny"
lb = require "lib.lovebird"

local Player = require("src.entities.Player")
local Light = require("src.entities.Light")
local BeatDisplay = require("src.entities.BeatDisplay")
local Platform = require("src.entities.Platform")

local conductor = require("src.systems.Conductor")
local drawSystem = require("src.systems.DrawSystem")
local playerControlSystem = require("src.systems.PlayerControlSystem")
local bumpSystem = require("src.systems.BumpSystem")

local width, height, flags = love.window.getMode()

local world = Tiny.world(
    conductor,
    drawSystem,
    playerControlSystem,
    bumpSystem,
    Player(100,100),
    Light(50,50,4,{0,1,2,3}),
    Light(100,50,4,{1,3}),
    Light(150,50,8,{2}),
    BeatDisplay(500,50,4),
    Platform(-width, height-100, width * 3, 100),
    Platform(300, 250, 100, 50)
)

function love.load()

end

function love.draw()
    local dt = love.timer.getDelta()
    world:update(dt)
end

function love.update(dt)
    lb.update()
end