local FadeRender = require("timingsystem"):extend()

function FadeRender:init(...)
	FadeRender.super.init(self, ...)
	self.fade = 1
end

function FadeRender:fadeOut(time)
	self.tweens:to(self, time, {fade=1})
end

function FadeRender:fadeIn(time)
	self.tweens:to(self, time, {fade=0})
end

function FadeRender:flash()
	self.tweens:to(self, 0.05, {fade=1}):after(0.05, {fade=0})
end

function FadeRender:execute(...)
	FadeRender.super.execute(self, ...)

	if not self.enabled then return end

	if self.fade ~= 0 then
		love.graphics.setColor(255, 255, 255, 255*self.fade)
		love.graphics.rectangle("fill", 0,0, love.graphics.getWidth(), love.graphics.getHeight())
	end
end

return FadeRender
