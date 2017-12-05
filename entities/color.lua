local Color = require("entity"):extend()

function Color:init(color, points)
	local verts = {}
	for _, pt in ipairs(points) do
		table.insert(verts, pt.x)
		table.insert(verts, pt.y)
	end

	self:addComponent("colorrender", {
		verts = verts,
		color = color
	})
end

return Color
