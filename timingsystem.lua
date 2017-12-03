local TimingSystem = require("system"):extend()

function TimingSystem:init(...)
	TimingSystem.super.init(self, ...)

	self.threads = coil.group()
	self.tweens = flux.group()
end

function TimingSystem:execute()
	if not self.enabled then return end

	local dt = love.timer.getDelta()
	self.threads:update(dt)
	self.tweens:update(dt)
end

return TimingSystem
