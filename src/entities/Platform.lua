class = require("lib.30log")

local Platform = class("Platform")

function Platform:draw ()
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
end

function Platform:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.drawMode = "line"
end

return Platform