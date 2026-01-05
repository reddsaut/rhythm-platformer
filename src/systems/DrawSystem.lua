local drawSystem = Tiny.processingSystem()

drawSystem.filter = Tiny.requireAll("draw", "x", "y")

function drawSystem:process(e)
    e.draw(50, 50)
end

return drawSystem