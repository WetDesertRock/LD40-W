local LineRender = require("system"):extend()

function LineRender:execute()
	if not self.enabled then return end

	local camera = self.world:getSystem("camera"):getCamera()

	camera:attach()

	for uuid, data in pairs(self.components) do
		local entity = self.world:getEntity(uuid)

		love.graphics.setColor(0,0,0, 100)
		love.graphics.setLineWidth(3)
		love.graphics.line(data.verts)
		love.graphics.setLineWidth(1)
	end

	camera:detach()
end

return LineRender
