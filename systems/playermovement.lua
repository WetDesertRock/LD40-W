local PlayerMovement = require("system"):extend()

function PlayerMovement:execute(dt)
	if not self.enabled then return end

	local collisionSystem = self.world:getSystem("collision")
	local input = self.world:getSystem("input"):getInput()

	for uuid, data in pairs(self.components) do
		local composition = self:composeComponents(uuid, "position", "movement", "collision")
		local dir = Vector(input:get("move"))

		local npos = composition.position + dir * composition.movement.speed * dt

		if composition.collision then
			npos = collisionSystem:moveComponent(composition.entity, npos)
		end

		composition.position.x, composition.position.y = npos:unpack()
		composition.movement.direction = dir:heading()

	end
end

return PlayerMovement
