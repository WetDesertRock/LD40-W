local SnatcherRender = require("system"):extend()

function SnatcherRender:execute(dt)
	if not self.enabled then return end

	local camera = self.world:getSystem("camera"):getCamera()

	camera:attach()

	for uuid, eye in pairs(self.components) do
		local compo = self:composeComponents(uuid, "position")

		local dt = love.timer.getDelta()

		local time = love.timer.getTime()
		local rotationRate = 0
		rotationRate = rotationRate + math.sin((time * 6) + eye.phaseShift)
		rotationRate = rotationRate + math.tan((time * 3.2) - eye.phaseShift + 0.2)
		rotationRate = rotationRate + (math.cos((time * 11.0251546) - eye.phaseShift + 0.4) * 1.2)

		local heading = eye.direction:heading()
		local nvec = Vector.fromAngleMag(heading + rotationRate * dt, 1 )
		eye.direction = nvec


		-- Actually render it
		love.graphics.setColor(50, 20, 20)
		love.graphics.circle("fill", compo.position.x, compo.position.y, 8, 15)

		local epos = (eye.direction * 4) + compo.position
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle("line", epos.x, epos.y, 3)
	end

	camera:detach()
end

return SnatcherRender
