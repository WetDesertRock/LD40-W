local Mortal = require("system"):extend()

function Mortal:execute(dt)
	if not self.enabled then return end

	for uuid, data in pairs(self.components) do
		local composition = self:composeComponents(uuid, "mortal")

		if not composition.mortal.alive then
			-- Trigger event for entity if it exists (it should)
			if composition.entity.onDeath then
				composition.entity:onDeath()
			else
				print("WARNING: entity does not have a onDeath")
			end
		end
	end
end

return Mortal
