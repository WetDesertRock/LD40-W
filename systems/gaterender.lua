local GateRender = require("system"):extend()

function GateRender:execute()
	if not self.enabled then return end

	local camera = self.world:getSystem("camera"):getCamera()

	camera:attach()

	for uuid, data in pairs(self.components) do
		local entity = self.world:getEntity(uuid)
		local rect = entity:getComponent("rectangle")

		love.graphics.setColor(0, 207, 213)
		love.graphics.rectangle("fill", rect:unpack())

		local font = Media:getFont("Rounded_Elegance.ttf", 40)
		love.graphics.setColor(20, 20, 20)
		love.graphics.setFont(font)
		love.graphics.printf(data.title, rect.x,rect.y+3, rect.width, "center")
	end

	camera:detach()
end

return GateRender
