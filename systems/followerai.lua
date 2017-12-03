local FollowerAI = require("system"):extend()

function FollowerAI:execute(dt)
	if not self.enabled then return end

	local player = self.world:getBookmark("player")
	if player == nil then return end
	local playerpos = player:getComponent("position")

	for uuid, data in pairs(self.components) do
		if data.nextCheck <= 0 then
			local composition = self:composeComponents(uuid, "position", "mortal", "movement")

			local pdist = playerpos:distance(composition.position)

			-- If it is too far away: respawn
			if pdist > 2000 then
				composition.mortal.alive = false
			end

			local ldist = data.lastPosition:distance(composition.position)
			-- If the last recorded position isn't more than a ratio of its max speed: respawn
			if ldist < composition.movement.speed/8 then
				composition.mortal.alive = false
			end

			data.nextCheck = 1
			data.lastPosition = composition.position:clone()
		else
			data.nextCheck = data.nextCheck - dt
		end
	end
end

function FollowerAI:killAllFollowers()
	for uuid, data in pairs(self.components) do
		local composition = self:composeComponents(uuid, "mortal")
		composition.mortal.alive = false
	end
end

return FollowerAI
