Tiny = require "lib.tiny"

local player = require("src.entities.Player")
player:init(100, 100)
local drawSystem = require("src.systems.DrawSystem")
local PlayerControlSystem = require("src.systems.PlayerControlSystem")

local world = Tiny.world(drawSystem, PlayerControlSystem, player)

function love.load()

end

function love.draw()
    local dt = love.timer.getDelta()
    world:update(dt)
end

function love.update(dt)
end