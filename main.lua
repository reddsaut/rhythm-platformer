Tiny = require "lib.tiny"

local player = require("src.entities.Player")
player:init()
local drawSystem = require("src.systems.DrawSystem")

local world = Tiny.world(drawSystem, player)

function love.load()

end

function love.draw()
    world:update()
end

function love.update(dt)
end