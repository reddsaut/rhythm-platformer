class = require("lib.30log")

local Hazard = class("Hazard")

function Hazard:init (x, y, width, height)
    self.x = x
    self.y = y
    self.width = width or 50
    self.height = height or 50
    self.drawMode = "fill"

    self.isHazard = true
end

function Hazard:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
end

return Hazard