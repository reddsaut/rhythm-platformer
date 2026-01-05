local PlayerControlSystem = Tiny.processingSystem()

PlayerControlSystem.filter = Tiny.requireAll("move", "x", "y")

function PlayerControlSystem:process(e, dt)
	local l, r, u, d = love.keyboard.isDown('a') or love.keyboard.isDown('left'), love.keyboard.isDown('d') or love.keyboard.isDown('right'), love.keyboard.isDown('w') or love.keyboard.isDown('up'), love.keyboard.isDown("s") or love.keyboard.isDown('down')

	local width, height, flags = love.window.getMode()

	e.grounded = e.y >= (height - 200)

	if l and not r then
		e.x = e.x - e.speed * dt
	elseif r and not l then
		e.x = e.x + e.speed * dt
	end

	if u and not d then
		e.y = e.y - e.speed * dt
	elseif d and not u then
		if not e.grounded then e.y = e.y + e.speed * dt end
	end

end

return PlayerControlSystem