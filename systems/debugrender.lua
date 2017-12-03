local DebugRender = require("system"):extend()

function DebugRender:execute()
	if not self.enabled then return end

	local camera = self.world:getSystem("camera"):getCamera()

	camera:attach()

	for uuid, data in pairs(self.components) do
		local compo = self:composeComponents(uuid, "position", "collision")

		if compo.collision then
			local x,y = compo.collision.position:unpack()

			love.graphics.setColor(255,0,0)
			love.graphics.rectangle("line", x,y, compo.collision.width, compo.collision.height)
		end
	end

	camera:detach()
end

return DebugRender
