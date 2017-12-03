local switches = require("data.switches")

local Switch = require("entity"):extend()

function Switch:init(position, id)
	self:addComponent("position", position:clone())
	self:addComponent("worldrender", "switch")

	self:addComponent("switch", switches[id].data)
end

function Switch:onSwitch()
	local switch = self:getComponent("switch")
	if switch.sticky and switch.state then
		return
	end

	switch.state = not switch.state

	if switch.state then
		self:enable()
	else
		self:disable()
	end
end

function Switch:enable()
	local switch = self:getComponent("switch")
	local fun = switches[switch.id].enable(self, switch)
	Media:playSound("SwitchOn.ogg", 0.5)
end

function Switch:disable()
	local switch = self:getComponent("switch")
	local fun = switches[switch.id].disable(self, switch)
	Media:playSound("SwitchOff.ogg", 0.5)
end


return Switch
