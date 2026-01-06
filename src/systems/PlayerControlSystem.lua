local PlayerControlSystem = Tiny.processingSystem()

PlayerControlSystem.filter = Tiny.requireAll("move", "x", "y")

function PlayerControlSystem:process(e, dt)
	local l, r, u, d = love.keyboard.isDown('a') or love.keyboard.isDown('left'), love.keyboard.isDown('d') or love.keyboard.isDown('right'), love.keyboard.isDown('w') or love.keyboard.isDown('up'), love.keyboard.isDown("s") or love.keyboard.isDown('down')
	local jump = love.keyboard.isDown('space')

	local width, height, flags = love.window.getMode()
	local vel = e.vel

	if l and not r then
		vel.x = -1 * e.speed
	elseif r and not l then
		vel.x = e.speed
	else
		vel.x = 0
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
    	vel.y = - 2000
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
    end

end

return PlayerControlSystem