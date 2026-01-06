local PlayerControlSystem = Tiny.processingSystem()

PlayerControlSystem.filter = Tiny.requireAll("move", "x", "y")

function PlayerControlSystem:process(e, dt)
	local l, r, u, d = love.keyboard.isDown('a') or love.keyboard.isDown('left'), love.keyboard.isDown('d') or love.keyboard.isDown('right'), love.keyboard.isDown('w') or love.keyboard.isDown('up'), love.keyboard.isDown("s") or love.keyboard.isDown('down')
	local jumpPressed = love.keyboard.isDown('space')
	local dashPressed = love.keyboard.isDown('j')

	local width, height, flags = love.window.getMode()
	local vel = e.vel

	--------- LEFT AND RIGHT ---------
	if l and not r then
		vel.x = -1 * e.speed
		e.direction = -1
	elseif r and not l then
		vel.x = e.speed
		e.direction = 1
	else
		vel.x = 0
	end

	--------- JUMP ---------
    if not jumpPressed then
    	e.canJump = true
    	e.jumpTime = 0
    end

    if e.jumpTime > 0 then
    	vel.y = - 2000
    	e.jumpTime = e.jumpTime - dt
    end

    if e.grounded and jumpPressed and e.canJump then
    	e.jumpTime = .1
    	e.canJump = false
    end

    --------- DASH ---------
    if e.canDash and dashPressed then
    	e.dashTime = .15
    	e.canDash = false
    	e.gravity = 0
    	vel.y = 0
    	e.width = e.dashSize.w
    	e.height = e.dashSize.h
    end

    if e.dashTime > 0 then
    	vel.x = 2000 * e.direction
   		e.dashTime = e.dashTime - dt
   	end

   	if e.dashTime <= 0 then
   		e.gravity = e.ogGravity
   		e.width = e.sizeIdentity.w
    	e.height = e.sizeIdentity.h
   	end

   	if e.grounded and e.dashTime <= 0 and not dashPressed then
   		e.canDash = true
   		e.dashTime = 0
   	end

end

return PlayerControlSystem