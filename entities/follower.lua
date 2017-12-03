local Follower = require("entity"):extend()


function Follower:init(position)
	self:addComponent("position", position:clone())
	self:addComponent("movement", {
		speed = 100,
		direction = 0
	})
	self:addComponent("followermovement", {})
	self:addComponent("followerai", {
		lastPosition = position:clone(),
		nextCheck = love.math.random() + 1
	})

	self:addComponent("collision", {
		position = self:getComponent("position"):clone(),
		width = 20,
		height = 20,
		solid = true
	})

	self:addComponent("mortal", {
		alive = true
	})

	self:addComponent("worldrender", "enemy")
end

function Follower:onDeath()
	self.world:removeEntity(self)

	local player = self.world:getBookmark("player")
	if player == nil then
		print("WARNING: Unknown player for follower respawn")
	end
	local playerpos = player:getComponent("position")

	local dist = love.math.random(750, 1000)
	local offset = Vector.fromAngleMag(love.math.random() * math.pi, dist)

	local pos = playerpos + offset

	-- Add replacement follower
	self.world:addEntity(Follower, pos)
end


return Follower
