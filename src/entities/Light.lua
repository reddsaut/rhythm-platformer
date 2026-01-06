class = require("lib.30log")

local Light = class("Light")

function Light:init (x, y, loop_length, loop_hits)
    self.x = x
    self.y = y
    self.lit = false
    self.loop_length = loop_length
    self.loop_hits = {}
    for key, value in pairs(loop_hits) do
        self.loop_hits[value] = true
    end
end

function Light:draw ()
    if self.lit == true then
        love.graphics.circle("fill", self.x, self.y, 20, 20)
    else
        love.graphics.circle("line", self.x, self.y, 20, 20)
    end
end

function Light:beat (n)
    if self.loop_hits[n % self.loop_length] then
        self.lit = not self.lit
    end
end

return Light