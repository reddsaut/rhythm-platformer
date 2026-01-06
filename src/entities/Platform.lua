class = require("lib.30log")

local Platform = class("Platform")

-- function Platform:draw ()
--     love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
-- end

function Platform:init(gridX, gridY, gridWidth, gridHeight, TileMap)
	TileMap:createPlatform(gridX, gridX + gridWidth - 1, gridY, gridY + gridHeight - 1)
	self.x = (gridX - 1) * 32
	self.y = ((gridY - 1) * 32)
	self.width = gridWidth * 32
	self.height = gridHeight * 32
	self.drawMode = "line"
	self.isSolid = true
end

return Platform