class = require "lib.30log"
Tiny = require "lib.tiny"

local Player = require("src.entities.Player")
local Light = require("src.entities.Light")
local TileMap = require("src.entities.TileMap")
TileMap:init(32)
TileMap:createPlatform(15, 17, 10, 16)
TileMap:createPlatform(10, 20, 12, 13)
TileMap:createPlatform(15, 17, 10, 16)
TileMap:createPlatform(1, 32, 24, 24)
TileMap:createMesh()

local DrawSystem = require("src.systems.DrawSystem")
local PlayerControlSystem = require("src.systems.PlayerControlSystem")

local world = Tiny.world(
    DrawSystem,
    PlayerControlSystem,
    Player(100,100),
    Light(50,50),
    Light(100,50),
    TileMap
)

function love.load()

end

function love.draw()
    local dt = love.timer.getDelta()
    world:update(dt)
end

function love.update(dt)
end