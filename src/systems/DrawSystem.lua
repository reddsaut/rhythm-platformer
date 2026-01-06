local drawSystem = Tiny.processingSystem()

drawSystem.filter = Tiny.requireAll("draw")

function drawSystem:process(e, dt)
    e:draw(dt)
end

return drawSystem