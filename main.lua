class = require "lib.30log"
Tiny = require "lib.tiny"
lb = require "lib.lovebird"
camera = require "lib.camera"


local zoom = 1
local cam = camera(love.graphics.getWidth()/2,love.graphics.getHeight()*zoom/2,1-math.abs(zoom-1))

local Player = require("src.entities.Player")
local Light = require("src.entities.Light")
local TileMap = require("src.entities.TileMap")
local WorldLaser = require("src.entities.WorldLaser")
TileMap:init(32, zoom)
local BeatDisplay = require("src.entities.BeatDisplay")
local Platform = require("src.entities.Platform")
local Hazard = require("src.entities.Hazard")
local Enemy = require("src.entities.Enemy")

local Laser = require("src.entities.Laser")

local conductor = require("src.systems.Conductor")
local drawSystem = require("src.systems.DrawSystem")
local playerControlSystem = require("src.systems.PlayerControlSystem")
local bumpSystem = require("src.systems.BumpSystem")

local width, height, flags = love.window.getMode()

--Level 1 Creation
TileMap:createMesh()
local platforms = {}
table.insert(platforms, Platform(1, 22, 8, 4, TileMap))
table.insert(platforms, Platform(25, 22, 8, 4, TileMap))
table.insert(platforms, Platform(13, 15, 8, 2, TileMap))
table.insert(platforms, Platform(16, 13, 2, 3, TileMap))
table.insert(platforms, Platform(1, 9, 8, 2, TileMap))
table.insert(platforms, Platform(25, 9, 8, 2, TileMap))
TileMap:createMesh()



local world = Tiny.world(
    conductor,
    drawSystem,
    playerControlSystem,
    bumpSystem,
    TileMap,
    Enemy(300,300),
    Player(100,100),
    Light(50,50,4,{0,1,2,3}),
    Light(100,50,4,{1,3}),
    Light(150,50,8,{2}),
    BeatDisplay(500,50,4),
    Hazard(8 * 32, 23 * 32, 16 * 32, 2 * 32),
    WorldLaser({20, 7})
)
for i, v in ipairs(platforms) do
    world:add(v)
end

world:addEntity(Laser(500, 450, 1000, 100))

function love.load()
end

function love.draw()
    local dt = love.timer.getDelta()
    cam:attach()
        world:update(dt)
    cam:detach()
end

function love.update(dt)
    lb.update()
end