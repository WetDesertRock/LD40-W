local bump = require("lib.bump")

local Collision = require("system"):extend()

function Collision:init(...)
	Collision.super.init(self, ...)

	self.bump = bump.newWorld(50)
	self.pendingCollisions = {}
end

function Collision:onAddComponent(entity, data)
	self.bump:add(entity.uuid, data.position.x, data.position.y, data.width, data.height)
end

function Collision:onRemoveComponent(entity, data)
	self.bump:remove(entity.uuid)
end

function Collision:moveComponent(entity, newPosition)
	local data = self.components[entity.uuid]

	local actualX, actualY, cols, len = self.bump:move(entity.uuid, newPosition:unpack())

	for _,col in ipairs(cols) do
		table.insert(self.pendingCollisions, col)
	end

	data.position.x, data.position.y = actualX, actualY

	return actualX, actualY
end

function Collision:execute(dt)
	if not self.enabled then return end

	for _, col in ipairs(self.pendingCollisions) do
		local entA = self.world:getEntity(col.item)
		local entB = self.world:getEntity(col.other)

		if entA.onContact then
			entA:onContact(entB)
		end

		if entB.onContact then
			entB:onContact(entA)
		end
	end
end

return Collision
