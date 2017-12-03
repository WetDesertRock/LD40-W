local Entity = Object:extend()

function Entity:new(world)
	self.uuid = lume.uuid()
	self.components = {}
	self.world = world
end

function Entity:init(...)
end

function Entity:getComponent(system)
	return self.components[system]
end


function Entity:composeComponents(...)
	local composition = {}
	composition.entity = self

	for _, component in ipairs({...}) do
		composition[component] = self:getComponent(component)
	end

	return composition
end

function Entity:addComponent(name, data)
	local system = self.world:getSystem(name)
	self.components[name] = data
	system:addComponent(self, data)
end

function Entity:removeComponent(name)
	local system = self.world:getSystem(name)
	system:removeComponent(self)
	self.components[name] = nil
end

function Entity:removeAllComponents()
	for name,data in pairs(self.components) do
		self:removeComponent(name)
	end
end

function Entity:onRemove()
end

return Entity
