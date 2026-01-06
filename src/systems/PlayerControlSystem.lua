local PlayerControlSystem = Tiny.processingSystem()

PlayerControlSystem.filter = Tiny.requireAll("move", "x", "y")

function PlayerControlSystem:process(e, dt)
	local l, r, u, d = love.keyboard.isDown('a') or love.keyboard.isDown('left'), love.keyboard.isDown('d') or love.keyboard.isDown('right'), love.keyboard.isDown('w') or love.keyboard.isDown('up'), love.keyboard.isDown("s") or love.keyboard.isDown('down')
	local jump = love.keyboard.isDown('space')

	local width, height, flags = love.window.getMode()

	if l and not r then
		e.dx = -1 * e.speed
	elseif r and not l then
		e.dx = e.speed
	else
		e.dx = 0
	end

	-- if e.x > width then
    --     e.x = e.x - width
    -- end

    -- if e.x < 0 then
    --     e.x = width + e.x
    -- end


    if not jump then
    	e.canJump = true
    	e.jumpTime = 0
    end

    if e.jumpTime > 0 then
    	e.dy = -1400
    	e.jumpTime = e.jumpTime - dt
    end

    if e.grounded then
    	e.drawMode = "fill"

    	if jump and e.canJump then 
    		e.jumpTime = .1
    		e.canJump = false
    	end
    else
    	e.drawMode = "line"
    	e.dy = e.dy + 100
    end

end

return PlayerControlSystem