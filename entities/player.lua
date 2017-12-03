local Player = require("entity"):extend()

function Player:init()
	-- self:addComponent("position", Vector(0,0))
	self:addComponent("movement", {
		speed = 100
	})
	self:addComponent("worldrender", "player")
  --
	-- self:addComponent("collision", {
	-- 	position = self:getComponent("position"):clone(),
	-- 	width = 20,
	-- 	height = 20,
	-- 	solid = true
	-- })
  --
	-- self:addComponent("mortal", {
	-- 	alive = true
	-- })

	self.world:addBookmark("player", self)
end

function Player:onDeath()
	self:removeComponent("playermovement")
	self:removeComponent("collision")
	self:removeComponent("mortal")
	self.world:removeBookmark("player")
end

function Player:onContact(other)
	if other:is(require("entities.follower")) then
		local mortal = self:getComponent("mortal")
		if mortal then mortal.alive = false end
	end
end


return Player
