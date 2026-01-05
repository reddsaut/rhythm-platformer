local player = {}

player.draw = function ()
        love.graphics.rectangle(player.drawMode, player.x, player.y, 50, 100)
end

function player:init (x, y)
    self.x = x
    self.y = y
    self.move = 0
    self.speed = 1000
    self.grounded = false
    self.vert = 0
    self.drawMode = "line"
end

return player