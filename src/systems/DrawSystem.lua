local drawSystem = Tiny.processingSystem()

drawSystem.filter = Tiny.requireAll("draw", "x", "y")

function drawSystem:process(e)
    e:draw()
end

return drawSystem