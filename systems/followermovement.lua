local FollowerMovement = require("system"):extend()

function FollowerMovement:execute(dt)
	if not self.enabled then return end

	local player = self.world:getBookmark("player")
	if player == nil then return end

	local collisionSystem = self.world:getSystem("collision")

	local playercomp = player:composeComponents("position")

	for uuid, data in pairs(self.components) do
		local composition = self:composeComponents(uuid, "position", "movement", "collision")
		local player

		local ndir = (playercomp.position - composition.position):normalize()

		local npos = composition.position + ndir * composition.movement.speed * dt

		if composition.collision then
			npos = collisionSystem:moveComponent(composition.entity, npos)
		end

		composition.position.x, composition.position.y = npos:unpack()
		composition.movement.direction = ndir:heading()
	end
end

return FollowerMovement
