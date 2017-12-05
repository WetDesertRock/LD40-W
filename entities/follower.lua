local Follower = require("entity"):extend()


function Follower:init(position)
	self:addComponent("position", position:clone())
	self:addComponent("movement", {
		speed = 100 + love.math.random(-10,10),
		direction = 0
	})
	self:addComponent("followermovement", {})
	self:addComponent("followerai", {
		lastPosition = position:clone(),
		nextCheck = love.math.random() + 1,
		nextSprint = love.math.random(10)
	})

	self:addComponent("collision", {
		position = self:getComponent("position"):clone(),
		width = 16,
		height = 16,
		solid = true
	})

	self:addComponent("mortal", {
		alive = true
	})

	self:addComponent("followerrender", {})
end

function Follower:onDeath()
	self.world:removeEntity(self)

	self.world:getSystem("followerspawner"):spawn(1)
end


return Follower
