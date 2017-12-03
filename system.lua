local System = Object:extend()

function System:new()
	self.components = {}
	self.enabled = true
	self.world = nil
end

function System:init(world, ...)
	self.world = world
end

function System:composeComponents(uuid, ...)
	local entity = self.world:getEntity(uuid)

	return entity:composeComponents(...)
end

function System:enable()
	self.enabled = true
end

function System:disable()
	self.enabled = false
end

function System:addComponent(entity,data)
	self.components[entity.uuid] = data
	self:onAddComponent(entity, data)
end

function System:removeComponent(entity)
	self:onRemoveComponent(entity, self.components[entity.uuid])
	self.components[entity.uuid] = nil
end

function System:onAddComponent(...)
end

function System:onRemoveComponent(...)
end

function System:execute(...)
end

return System
