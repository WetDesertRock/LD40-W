local Switch = require("system"):extend()

function Switch:execute(dt)
	if not self.enabled then return end

	-- Get player info
	local player = self.world:getBookmark("player")
	if player == nil then return end

	local playercomp = player:composeComponents("position")

	-- Get Input object
	local input = self.world:getSystem("input"):getInput()

	-- If the switch button has been pressed
	if input:pressed("switch") then
		for uuid, data in pairs(self.components) do
			-- Check distance, if it is within a good range fire the switch
			local composition = self:composeComponents(uuid, "position", "switch")

			local dist = composition.position:distance(playercomp.position)
			if dist < 30 then
				composition.entity:onSwitch()
			end
		end
	end
end

return Switch
