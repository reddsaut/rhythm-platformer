local PlayerControlSystem = Tiny.processingSystem()

PlayerControlSystem.filter = Tiny.requireAll("move", "x", "y")

function PlayerControlSystem:process(e)
	local l, r, u, d = love.keyboard.isDown('a'), love.keyboard.isDown('d'), love.keyboard.isDown('w'), love.keyboard.isDown("s")

	if l and not r then
		e.x = e.x - 2
	elseif r and not l then
		e.x = e.x + 2
	end

	if u and not d then
		e.y = e.y - 2
	elseif d and not u then
		e.y = e.y + 2
	end

end

return PlayerControlSystem