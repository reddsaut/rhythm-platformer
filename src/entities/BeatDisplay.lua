class = require("lib.30log")

local BeatDisplay = class("BeatDisplay")

function BeatDisplay:init (x, y, loop_length)
    self.x = x
    self.y = y
    self.loop_length = loop_length
    self.num = 0
end

function BeatDisplay:draw ()
    --love.graphics.print(self.num,self.x,self.y)
end

function BeatDisplay:beat (n)
    self.num = n % self.loop_length
end

return BeatDisplay