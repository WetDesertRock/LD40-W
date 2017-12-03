local SnatcherEye = require("system"):extend()

function SnatcherEye:execute(dt)
	if not self.enabled then return end


	for uuid, eye in pairs(self.components) do
		local time = love.timer.getTime()
		local rotationRate = 0
		rotationRate = rotationRate + math.sin((time * 6) + eye.phaseShift)
		rotationRate = rotationRate + math.tan((time * 3.2) - eye.phaseShift + 0.2)
		rotationRate = rotationRate + (math.cos((time * 11.0251546) - eye.phaseShift + 0.4) * 1.2)

		local heading = eye.direction:heading()
		-- print(rotationRate * dt)
		local nvec = Vector.fromAngleMag(heading + rotationRate * dt, 1 )
		eye.direction = nvec
	end
end

return SnatcherEye
