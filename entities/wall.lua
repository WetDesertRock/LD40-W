local Wall = require("entity"):extend()


function Wall:init(center, rect)
	self:addComponent("rectangle", rect:clone())
	self:addComponent("collision", {
		position = center:clone(),
		width = rect.width,
		height = rect.height,
		solid = true
	})

	self:addComponent("wallrender", {})
end

return Wall
