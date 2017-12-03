local TimingSystem = require("system"):extend()

function TimingSystem:init(...)
	TimingSystem.super.init(self, ...)

	self.threads = coil.group()
	self.tweens = flux.group()
	self.lastUpdate = love.timer.getTime()
end

function TimingSystem:execute()
	if not self.enabled then return end

	local now = love.timer.getTime()
	local dt = now - self.lastUpdate

	self.threads:update(dt)
	self.tweens:update(dt)

	self.lastUpdate = now
end

return TimingSystem
