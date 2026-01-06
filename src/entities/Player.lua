class = require("lib.30log")

local Player = class("Player")

function Player:init (x, y)
    self.x = x
    self.y = y
    self.width = 50
    self.height = 50
    self.drawMode = "line"

    self.speed = 1000
    self.dx = 0
    self.dy = 0

    self.jumpTime = 0
    self.grounded = false
    self.vert = 0
    self.canJump = true

    self.move = 0
end

function Player:draw()
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
end

return Player