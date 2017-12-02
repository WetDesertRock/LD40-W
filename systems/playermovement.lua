local PlayerMovement = require("system"):extend()

function PlayerMovement:execute(dt)
	if not self.enabled then return end

	local collisionSystem = self.world:getSystem("collision")

	for uuid, data in pairs(self.components) do
		local composition = self:composeComponents(uuid, "position", "movement", "collision")
		local dir = Vector(0,0)

		if love.keyboard.isDown("w") then
			dir.y = -1
		end
		if love.keyboard.isDown("s") then
			dir.y = 1
		end
		if love.keyboard.isDown("a") then
			dir.x = -1
		end
		if love.keyboard.isDown("d") then
			dir.x = 1
		end

		local npos = composition.position + dir * composition.movement.speed * dt

		if composition.collision then
			npos.x, npos.y = collisionSystem:moveComponent(composition.entity, npos)
		end

		composition.position.x, composition.position.y = npos:unpack()
		composition.movement.direction = dir:heading()

	end
end

return PlayerMovement
