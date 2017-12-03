local SnatcherAI = require("coilsystem"):extend()

function SnatcherAI:execute(dt)
	SnatcherAI.super.execute(self, dt)
	if not self.enabled then return end

	local collisionSystem = self.world:getSystem("collision")

	for uuid, data in pairs(self.components) do
		local compo = self:composeComponents(uuid, "position", "movement", "snatcherai")

		if data.cooldown <= 0 then
			local ents = collisionSystem:getCloseEntities(compo.position, compo.snatcherai.range)

			-- Go through the matching ents
			for _, other in ipairs(ents) do
				-- Verify they aren't us
				if other.uuid ~= uuid then
					-- Make sure they are mortal
					if other:getComponent("mortal") then
						-- ATTACK!
						self:attack(compo.entity, other)
						break
					end
				end
			end
		else
			data.cooldown = data.cooldown - dt
		end
	end
end

function SnatcherAI:attack(this, other)
	local thisCompo = this:composeComponents("position", "snatcherai")
	local otherCompo = other:composeComponents("position", "mortal")

	thisCompo.snatcherai.cooldown = 0.5

	-- Remove targets movement
	other:removeComponent("followermovement")
	other:removeComponent("playermovement")

	thisCompo.position.x, thisCompo.position.y = otherCompo.position:unpack()

	self.threads:add(function()
		otherCompo.mortal.alive = false
		coil.wait(0.2)
		thisCompo.position.x, thisCompo.position.y = thisCompo.snatcherai.origin:unpack()
	end)
end




return SnatcherAI
