local CoilSystem = require("system"):extend()

function CoilSystem:init(...)
	CoilSystem.super.init(self, ...)

	self.threads = coil.group()
end

function CoilSystem:execute(dt)
	if not self.enabled then return end

	self.threads:update(dt)
end

return CoilSystem
