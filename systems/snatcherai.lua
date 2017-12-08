local SnatcherAI = require("timingsystem"):extend()

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

	thisCompo.snatcherai.cooldown = 0.3

	-- Remove targets movement
	other:disableComponent("followermovement")
	other:disableComponent("playermovement")

	local tgtx,tgty = otherCompo.position:unpack()
	local originx,originy = thisCompo.snatcherai.origin:unpack()

	self.tweens:to(thisCompo.position, 0.06, {x = tgtx, y = tgty}):oncomplete(function()
		otherCompo.mortal.alive = false
		local snd = self.world:getSystem("soundsystem"):playSound({
			"LD40_Snatches-01.ogg",
			"LD40_Snatches-02.ogg",
			"LD40_Snatches-03.ogg",
			"LD40_Snatches-04.ogg",
			"LD40_Snatches-05.ogg",
			"LD40_Snatches-06.ogg"
		}, thisCompo.position)

		if snd and other:is(require("entities.player")) then
			snd:setRelative(true)
			snd:setPosition(0,0,0)
			snd:setVolume(1)
		end

		if not other:getComponent("followermovement") then
			other:enableComponent("followermovement")
		end
		if not other:getComponent("playermovement") then
			other:enableComponent("playermovement")
		end
		self.tweens:to(thisCompo.position, 0.15, {x = originx, y = originy})
	end)
end

return SnatcherAI
