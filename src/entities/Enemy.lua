class = require("lib.30log")
animate = require("animation")

local Enemy = class("Enemy")

local snap_points = {{100, 600}, {924, 600}, {100, 200}, {924, 200}}
local loop_hits = {0, 2, 4, 6}

function Enemy:init (x, y)
    self.x = x
    self.y = y
    self.vel = {x = 0, y = 0}
    self.width = 56
    self.height = 56
    self.target_point = 4
    self.loop_length = 8
    self.loop_hits = {}
    self.quads = animate.makeQuads(love.graphics.newImage("sprites/evil_red_ball.png"), 32, 32)
    self.isHazard = true
    for key, value in pairs(loop_hits) do
        self.loop_hits[value] = true
    end
end

function Enemy:draw(dt)
    local target = {x=snap_points[self.target_point][1],y=snap_points[self.target_point][2]}

    -- update velocity
    self.vel.x = self.vel.x / 1.2 + ( target.x - self.x ) / 1.5
    self.vel.y = self.vel.y / 1.2 + ( target.y - self.y ) / 1.5

    -- update position
    self.x = self.x + self.vel.x * dt
    self.y = self.y + self.vel.y * dt

    -- draw
    love.graphics.draw(love.graphics.newImage("sprites/evil_red_ball.png"), self.quads[1], self.x, self.y, 0, 2, 2, 2, 2)
    love.graphics.rectangle("line",self.x,self.y,self.width,self.height) --hitbox
end

function Enemy:beat(n)
    if n == 0 then
        local rand = love.math.random(3)
        if rand >= self.target_point then rand = rand + 1 end
        self.target_point = rand
    end
end

return Enemy