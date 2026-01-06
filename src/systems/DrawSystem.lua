local drawSystem = Tiny.processingSystem()

drawSystem.filter = Tiny.requireAll("draw")

function drawSystem:process(e)
    e:draw()
end

return drawSystem