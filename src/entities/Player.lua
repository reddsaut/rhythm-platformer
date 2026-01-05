class = require("lib.30log")

local Player = class("Player")

function Player:init (x, y)
    self.x = x
    self.y = y
    self.move = 0
    self.speed = 1000
    self.grounded = false
    self.vert = 0
    self.drawMode = "line"
end

function Player:draw()
        love.graphics.rectangle(self.drawMode, self.x, self.y, 50, 100)
end

return Player