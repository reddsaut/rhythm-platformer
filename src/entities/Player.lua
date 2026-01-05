local player = {}

function player:init ()
    self.draw = function (x, y)
        love.graphics.rectangle("line", x, y, 50, 100)
    end
    self.x = 50
    self.y = 50
end

return player