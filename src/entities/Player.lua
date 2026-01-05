local player = {}

player.draw = function ()
        love.graphics.rectangle("line", player.x, player.y, 50, 100)
end

function player:init (x, y)
    self.x = x
    self.y = y
    self.move = 0
end

return player