class = require("lib.30log")

local Light = class("Light")

function Light:init (x, y)
    self.x = x
    self.y = y
    self.lit = false
end

function Light:draw ()
    if self.lit == true then
        love.graphics.circle("fill", self.x, self.y, 20, 20)
    else
        love.graphics.circle("line", self.x, self.y, 20, 20)
    end
end

function Light:beat ()
    self.lit = not self.lit
end

return Light