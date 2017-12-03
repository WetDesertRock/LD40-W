local SwitchRender = require("system"):extend()

function SwitchRender:execute()
	if not self.enabled then return end

	local camera = self.world:getSystem("camera"):getCamera()

	camera:attach()

	for uuid, data in pairs(self.components) do
		local compo = self:composeComponents(uuid, "position", "switch")

		local size = Vector(20, 30)
		local sx,sy = (compo.position - size / 2):unpack()

		love.graphics.setColor(20, 20, 120)
		love.graphics.rectangle("fill", sx,sy, size.x,size.y, 10)

		-- Draw switch indicator
		local offset = Vector(0, 8)
		if compo.switch.state then
			offset = offset * -1
		end

		local x,y = (compo.position + offset):unpack()
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle("line", x,y, 6)

		-- Draw name
		local x,y = (compo.position + Vector(-32, 24)):unpack()
		local limit = 64
		local font = Media:getFont("Rounded_Elegance.ttf", 40)

		love.graphics.setColor(20, 20, 120)
		love.graphics.setFont(font)
		love.graphics.printf(compo.switch.title, x,y, limit, "center")
	end

	camera:detach()
end

return SwitchRender
