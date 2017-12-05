local LineRender = require("system"):extend()

local colors = {
	red = {215, 84, 56, 255},
	blue = {37, 81, 134, 255},
	lightblue = {209, 212, 220, 255},
	yellow = {242, 210, 108, 255}
}

function LineRender:execute()
	if not self.enabled then return end

	local camera = self.world:getSystem("camera"):getCamera()

	camera:attach()

	for uuid, data in pairs(self.components) do
		local entity = self.world:getEntity(uuid)

		love.graphics.setColor(colors[data.color])
		love.graphics.polygon("fill", data.verts)
	end

	camera:detach()
end

return LineRender
