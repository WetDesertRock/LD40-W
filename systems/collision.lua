local bump = require("lib.bump")

local Collision = require("system"):extend()

function Collision:init(...)
	Collision.super.init(self, ...)

	self.bump = bump.newWorld(50)
	self.pendingCollisions = {}
end

function Collision:onAddComponent(entity, data)
	-- Shift to non-center based position
	data.position = data.position - (Vector(data.width, data.height) / 2 )
	self.bump:add(entity.uuid, data.position.x, data.position.y, data.width, data.height)
end

function Collision:onRemoveComponent(entity, data)
	self.bump:remove(entity.uuid)
end

function Collision:getCloseEntities(center, range)
	local items = self.bump:queryRect(center.x - range, center.y - range, range*2, range*2)

	local entities = {}
	for _,uuid in ipairs(items) do
		local ent = self.world:getEntity(uuid)
		local pos = ent:getComponent("position")
		if pos:distance(center) < range then
			table.insert(entities, ent)
		end
	end

	return entities
end

function Collision:moveComponent(entity, newPosition)
	local data = self.components[entity.uuid]


	newPosition = newPosition - (Vector(data.width, data.height) / 2 )

	-- local actualX, actualY, cols, len = self.bump:move(entity.uuid, newPosition.x, newPosition.y, function(i, o)
	-- 	local other = self:composeComponents(o, "collision")
	-- 	if other.collision.solid and data.solid then
	-- 		return "slide"
	-- 	else
	-- 		return "cross"
	-- 	end
	-- end)
	local actualX, actualY, cols, len = self.bump:move(entity.uuid, newPosition.x, newPosition.y)

	for _,col in ipairs(cols) do
		table.insert(self.pendingCollisions, col)
	end

	data.position.x, data.position.y = actualX, actualY

	return Vector(actualX, actualY) + (Vector(data.width, data.height) / 2 )
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
	self.pendingCollisions = {}
end

return Collision
