class = require("lib.30log")

local Laser = class("Laser")

local LaserSegment = require("src.entities.LaserSegment")

function Laser:init (x1, y1, x2, y2)
    self.startpos = {x = x1, y = y1}
    self.endpos = {x = x2, y = y2}

    self.lineWidth = 5

    -- this is the "hitbox" of the laser
    self.x = x1
    self.y = y1
    self.width = self.lineWidth
    self.height = self.lineWidth
    self.destination = {x = x2, y = y2}

    self.isHazard = false -- also acts as a toggle for whether or not the laser exists
end

function Laser:moveHitbox()
    if self.destination.x == self.endpos.x then
        self.destination = self.startpos
    else
        self.destination = self.endpos
    end
end

function Laser:draw()
    if self.isHazard then
        self:moveHitbox()
        love.graphics.setColor(1, 0, 0)
        love.graphics.setLineWidth(self.lineWidth)
        love.graphics.line(self.startpos.x, self.startpos.y, self.endpos.x, self.endpos.y)
        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(1)
    end
end

return Laser