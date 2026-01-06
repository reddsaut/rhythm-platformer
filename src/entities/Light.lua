class = require("lib.30log")

local Light = class("Light")

function Light:init (x, y, loop_length, loop_hits)
    self.x = x
    self.y = y
    self.lit = false
    self.brightness = 0
    self.loop_length = loop_length
    self.loop_hits = {}
    for key, value in pairs(loop_hits) do
        self.loop_hits[value] = true
    end
end

function Light:draw (dt)
    love.graphics.setColor(self.brightness,0,0)
    self.brightness = self.brightness - 1 * dt
    love.graphics.circle("fill", self.x, self.y, 20, 20)
    love.graphics.setColor(1,1,1)
end

function Light:beat ()
    self.brightness = 1
end

return Light