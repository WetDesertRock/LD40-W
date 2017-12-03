local FollowerSpawner = require("timingsystem"):extend()

function FollowerSpawner:init(...)
	FollowerSpawner.super.init(self, ...)

	self.rate = 0.8
	self.pendingSpawns = 0
	self.threads:add(function()
		while true do
			coil.wait(self.rate)
			if self.pendingSpawns > 0 then
				local success = self:createFollower()
				if success then self.pendingSpawns = self.pendingSpawns - 1 end
			end
		end
	end)
end

function FollowerSpawner:createFollower()
	local player = self.world:getBookmark("player")
	if player == nil then
		print("WARNING: Unknown player for follower respawn")
		return false
	end
	local playerpos = player:getComponent("position")

	local dist = love.math.random(750, 1000)
	local offset = Vector.fromAngleMag(love.math.random() * math.pi * 2, dist)

	self.world:addEntity(require("entities.follower"), offset + playerpos)
	return true
end

function FollowerSpawner:spawn(count)
	self.pendingSpawns = self.pendingSpawns + count
end

return FollowerSpawner
