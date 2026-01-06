class = require("lib.30log")

local Player = class("Player")

function Player:init (x, y)
    self.x = x
    self.y = y
    self.sizeIdentity = {w = 50, h = 50}
    self.width = 50
    self.height = 50
    self.drawMode = "line"

    self.speed = 1000
    self.vel = {x = 0, y = 0}

    self.jumpTime = 0
    self.grounded = false
    self.vert = 0
    self.canJump = true

    self.dashTime = 0
    self.direction = 1
    self.canDash = true
    self.dashSize = {w = 75, h = 25}

    self.gravity = 170
    self.ogGravity = 170

    self.move = 0
    self.isPlayer = true

    self.lives = 3

    self.checkPointX = x
    self.checkPointY = y
end

function Player:draw()
    if self.grounded or self.dashTime > 0 then
        self.drawMode = "fill"
    else
        self.drawMode = "line"
    end

    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
end

function Player:die()
    self.vel.x = 0
    self.vel.y = 0
    self.jumpTime = 0
    if self.lives > 0 then
        self.lives = self.lives - 1
    else
        -- self.x = beepis
    end
end

return Player