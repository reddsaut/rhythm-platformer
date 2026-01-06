class = require("lib.30log")
animate = require("animation")

local Enemy = class("Enemy")

function Enemy:init (x, y)
    self.x = x
    self.y = y
    self.quads = animate.makeQuads(love.graphics.newImage("sprites/evil_red_ball.png"), 32, 32)
end

function Enemy:draw()
    love.graphics.draw(love.graphics.newImage("sprites/evil_red_ball.png"), self.quads[1], self.x, self.y)
end

return Enemy