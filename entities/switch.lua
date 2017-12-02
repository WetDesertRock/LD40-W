local Switch = require("entity"):extend()

function Switch:init(...)
	Switch.super.init(self, ...)

	self:addComponent("position", Vector(-20,-50))
	self:addComponent("worldrender", "switch")
	self:addComponent("switch", {
		id = "switch1",
		sticky = false,
		state = false
	})

	-- self:addComponent("collision", {
	-- 	position = self:getComponent("position"):clone(),
	-- 	width = 20,
	-- 	height = 20,
	-- 	solid = false
	-- })
end

function Switch:onSwitch()
	local switch = self:getComponent("switch")
	if switch.sticky and switch.state then
		return
	end

	switch.state = not switch.state
end


return Switch
