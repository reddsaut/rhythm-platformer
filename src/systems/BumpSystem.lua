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

local function forceMoveFilter(e1, e2)
	if e1.isPlayer then return 'cross' end
end

local function collisionFilter(e1, e2)
    if e1.isPlayer then
        if e2.isHazard then return 'cross' end
        if e2.isSolid then return 'slide' end
    elseif e1.isHazard then
        if e2.isHazard then return nil end
        if e2.isPlayer then return 'cross' end
    elseif e1.isSolid then
    	if e2.isPlayer then return 'slide' end
    end
end

function BumpSystem:process(e, dt)
	local x, y = e.x, e.y
	local vel = e.vel
	local gravity = e.gravity or 0
	if vel then vel.y = vel.y + gravity end
	e.grounded = false

	if e.morph then
		bumpWorld:update(e, x, y, e.width, e.height)
	end

	if vel then

		e.x, e.y, cols, len = bumpWorld:move(e, x + vel.x * dt, y + vel.y * dt, collisionFilter) -- move player

		for i=1,len do
			local col = cols[i]
			if col.item.isPlayer and col.other.isHazard then
				col.item:die()
				vel.x = 0
				vel.y = 0
				e.x, e.y = bumpWorld:move(e, e.checkPointX, e.checkPointY, forceMoveFilter)
			end
			if col.type == "slide" then
            	if col.normal.x == 0 then
                	vel.y = 0
                	if col.normal.y < 0 then
                    	e.grounded = true
                	end
            	else
                	vel.x = 0
            	end
            end
		end
	end
end

return BumpSystem