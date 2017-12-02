local Follower = require("entity"):extend()


function Follower:init(...)
	Follower.super.init(self, ...)

	self:addComponent("position", Vector(200,200))
	self:addComponent("movement", {
		speed = 100,
		direction = 0
	})
	self:addComponent("followermovement", {})

	self:addComponent("collision", {
		position = self:getComponent("position"):clone(),
		width = 20,
		height = 20
	})

	self:addComponent("mortal", {
		alive = true
	})

	self:addComponent("worldrender", "enemy")
end

function Follower:onDeath()
	self.world:removeEntity(self)
end


return Follower
