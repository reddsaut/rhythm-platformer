local drawSystem = Tiny.processingSystem()

drawSystem.filter = Tiny.requireAll("draw", "x", "y")

function drawSystem:process(e, dt)
    e:draw(dt)
end

return drawSystem