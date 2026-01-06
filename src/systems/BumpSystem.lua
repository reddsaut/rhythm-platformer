local BumpSystem = Tiny.processingSystem()

bump = require "lib.bump"
local bumpWorld = bump.newWorld()

BumpSystem.filter = Tiny.requireAll("x", "y", "width", "height")

function BumpSystem:onAdd(e)
	bumpWorld:add(e, e.x, e.y, e.width, e.height)
end

function BumpSystem:onRemove(e)
	bumpWorld:remove(e)
end

function BumpSystem:process(e, dt)
	if e.dx and e.dy then
		if e.isPlayer then

			local actualX, actualY, cols, len = bumpWorld:check(e, e.x, e.y + 1) -- something under u
			e.grounded = len > 0

			local actualX, actualY, cols, len = bumpWorld:check(e, e.x, e.y - 1) -- something over u
			if len > 0 and e.dy < 0 then e.dy = 0 end -- hit ur head

			if e.force then
				bumpWorld:move(e, e.checkPointX, e.checkPointY)
				e.force = false
			end

		end

		e.x, e.y, cols, len = bumpWorld:move(e, e.x + e.dx * dt, e.y + e.dy * dt) -- move player

		for i=1,len do
			local col = cols[i]
			if col.item.isPlayer and col.other.isHazard then
				col.item:die()
			end
		end
	end
end

return BumpSystem