class = require("lib.30log")
animate = require("animation")

local Enemy = class("Enemy")

                    --bottom left -bot right  -top left  -top right
local snap_points = {{100, 600}, {924, 600}, {100, 200}, {924, 200}}
local snap_animation = {{nil,4,6,10},{3,nil,9,6},{5,8,nil,4},{7,5,3,nil}}
local loop_hits = {0, 1, 2, 4, 6, 7}

function Enemy:init (x, y)
    self.x = x
    self.y = y
    self.vel = {x = 0, y = 0}
    self.width = 56
    self.height = 56
    self.target_point = 4
    self.look_point = 4
    self.animation = 1
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
    love.graphics.draw(love.graphics.newImage("sprites/evil_red_ball.png"), self.quads[self.animation], self.x, self.y, 0, 2, 2, 2, 2)
    -- love.graphics.rectangle("line",self.x,self.y,self.width,self.height) --hitbox
end

function Enemy:beat(n)
    if n == 0 then
        self.target_point = self.look_point
    end

    if n == 1 then
        self.animation = 1
    end

    if n == 6 then
        local rand = love.math.random(3)
        if rand >= self.target_point then rand = rand + 1 end
        self.look_point = rand
        self.animation = snap_animation[self.target_point][rand]
    end
end

return Enemy