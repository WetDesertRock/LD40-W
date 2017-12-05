local FollowerAI = require("timingsystem"):extend()

function FollowerAI:init(...)
	FollowerAI.super.init(self, ...)

	self.canSprint = false
end

function FollowerAI:execute(dt)
	FollowerAI.super.execute(self, dt)

	if not self.enabled then return end

	local player = self.world:getBookmark("player")
	if player == nil then return end
	local playerpos = player:getComponent("position")

	for uuid, data in pairs(self.components) do
		local composition = self:composeComponents(uuid, "position", "mortal", "movement")
		local pdist = playerpos:distance(composition.position)

		if data.nextCheck <= 0 then
			-- If it is too far away: respawn
			if pdist > 2000 then
				composition.mortal.alive = false
			end

			-- If the last recorded position isn't more than a ratio of its max speed: respawn
			local ldist = data.lastPosition:distance(composition.position)
			if ldist < composition.movement.speed/8 then
				composition.mortal.alive = false
			end

			data.nextCheck = 1
			data.lastPosition = composition.position:clone()
		else
			data.nextCheck = data.nextCheck - dt
		end

		-- Check if we cant sprint, if so, do it
		if pdist < 600 and pdist > 130 and self.canSprint then
			-- Check the timing
			if data.nextSprint <= 0 then
				local basespeed = composition.movement.speed
				composition.movement.speed = 600
				self.threads:add(function()
					coil.wait(0.3)
					composition.movement.speed = basespeed
				end)

				data.nextSprint = love.math.random() * 2 + 8
			else
				data.nextSprint = data.nextSprint - dt
			end
		end
	end
end

function FollowerAI:setSprintable(bool)
	self.canSprint = bool
end

function FollowerAI:killAllFollowers()
	for uuid, data in pairs(self.components) do
		local composition = self:composeComponents(uuid, "mortal")
		composition.mortal.alive = false
	end
end

return FollowerAI
