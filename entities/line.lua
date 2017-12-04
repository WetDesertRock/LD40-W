local Line = require("entity"):extend()

function Line:init(points)
	local verts = {}
	for _, pt in ipairs(points) do
		table.insert(verts, pt.x)
		table.insert(verts, pt.y)
	end
	
	self:addComponent("linerender", {
		verts = verts
	})
end

return Line
