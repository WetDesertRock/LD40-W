local BarrierRender = require("system"):extend()

function BarrierRender:execute()
	if not self.enabled then return end

	local camera = self.world:getSystem("camera"):getCamera()

	camera:attach()

	for uuid, data in pairs(self.components) do
		local entity = self.world:getEntity(uuid)

		local rect = entity:getComponent("rectangle")
		love.graphics.setColor(180,180,180)
		love.graphics.rectangle("fill", rect:unpack())
	end

	camera:detach()
end

return BarrierRender
