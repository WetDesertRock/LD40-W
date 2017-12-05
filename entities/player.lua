local Player = require("entity"):extend()

function Player:init(position)
	self:addComponent("position", position:clone())
	self:addComponent("movement", {
		speed = 300
	})
	self:addComponent("playerrender", {})

	self:addComponent("collision", {
		position = self:getComponent("position"):clone(),
		width = 14,
		height = 14,
		solid = true
	})

	self:addComponent("mortal", {
		alive = true
	})

	self:addComponent("checkpoint", {
		position = position:clone()
	})

	self.world:addBookmark("player", self)
end

function Player:onDeath()
	self:getComponent("mortal").alive = true
	self.world:getSystem("faderender"):flash()
	self:useCheckpoint()
end

function Player:onContact(other)
	if other:is(require("entities.follower")) then
		local mortal = self:getComponent("mortal")
		if mortal then mortal.alive = false end
	end
end

function Player:setCheckpoint()
	local checkpoint = self:getComponent("checkpoint")
	local position = self:getComponent("position")
	checkpoint.position = position:clone()
end

function Player:useCheckpoint()
	local checkpoint = self:getComponent("checkpoint")
	local position = self:getComponent("position")
	position.x,position.y = checkpoint.position:unpack()

	self.world:getSystem("collision"):teleportComponent(self, position)
	-- Kill all followers
	self.world:getSystem("followerai"):killAllFollowers()
end

return Player
