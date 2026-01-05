local PlayerControlSystem = Tiny.processingSystem()

PlayerControlSystem.filter = Tiny.requireAll("move", "x", "y")

function PlayerControlSystem:process(e, dt)
	local l, r, u, d = love.keyboard.isDown('a') or love.keyboard.isDown('left'), love.keyboard.isDown('d') or love.keyboard.isDown('right'), love.keyboard.isDown('w') or love.keyboard.isDown('up'), love.keyboard.isDown("s") or love.keyboard.isDown('down')
	local jump = love.keyboard.isDown('space')

	local width, height, flags = love.window.getMode()

	e.grounded = e.y >= (height - 200)

	if l and not r then
		e.x = e.x - e.speed * dt
	elseif r and not l then
		e.x = e.x + e.speed * dt
	end

	if e.x > width then
        e.x = e.x - width
    end

    if e.x < 0 then
        e.x = width + e.x
    end

    e.y = e.y + e.vert * dt
    if e.grounded then
    	e.drawMode = "fill"

    	if jump then 
    		e.vert = -2000 
    	else
    		e.vert = 0
    	end
    else
    	e.drawMode = "line"
    	e.vert = e.vert + 100
    end

end

return PlayerControlSystem