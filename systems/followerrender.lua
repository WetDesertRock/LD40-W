local FollowerRender = require("system"):extend()

function FollowerRender:execute()
	if not self.enabled then return end

	local camera = self.world:getSystem("camera"):getCamera()

	camera:attach()

	for uuid, data in pairs(self.components) do
		local compo = self:composeComponents(uuid, "position")

		love.graphics.setColor(20, 20, 20)
		love.graphics.circle("fill", compo.position.x, compo.position.y, 10, 15)
	end

	camera:detach()
end

return FollowerRender
