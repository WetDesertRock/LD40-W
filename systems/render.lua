local Render = require("system"):extend()

function Render:execute(dt)
	if not self.enabled then return end

	for uuid, data in pairs(self.components) do
		local compo = self:composeComponents(uuid, "position", "collision")

		local offX,offY = 0,0

		if compo.collision then
			offX = compo.collision.width/2
			offY = compo.collision.height/2
		end

		love.graphics.setColor(20, 20, 20)
		love.graphics.circle("fill", compo.position.x + offX, compo.position.y + offY, 10, 15)
	end
end

return Render
