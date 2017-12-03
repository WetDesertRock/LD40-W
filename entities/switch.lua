local Switch = require("entity"):extend()

local switchRoutines = {
	graphicsSwitch = {
		enable = function(self, switch)
			-- Enable world renderer
			local worldRenderer = self.world:getSystem("worldrender")
			worldRenderer:enable()

			-- Disable "Press button" text
			local text = self.world:getBookmark("graphicsSwitch_text")
			if text then
				self.world:removeEntity(text)
			end

			-- Add playermovement
			local player = self.world:getBookmark("player")
			player:addComponent("playermovement", {})
		end,
		disable = function(self, switch) end -- Sticky switch
	}
}

function Switch:init()
	-- self:addComponent("position", Vector(0,0))
	self:addComponent("worldrender", "switch")
	-- self:addComponent("switch", {
	-- 	id = "graphicsSwitch",
	-- 	title = "G",
	-- 	sticky = true,
	-- 	state = false
	-- })

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

	print(switch.id)
	if switch.state then
		self:enable()
	else
		self:disable()
	end
end

function Switch:enable()
	local switch = self:getComponent("switch")
	local fun = switchRoutines[switch.id].enable(self, switch)
end

function Switch:disable()
	local switch = self:getComponent("switch")
	local fun = switchRoutines[switch.id].disable(self, switch)
end


return Switch
