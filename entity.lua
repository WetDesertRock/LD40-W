local Entity = Object:extend()

function Entity:new(world)
	self.uuid = lume.uuid()
	self.components = {}
	self.disabledComponents = {}
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
	assert(self.components[name] == nil, "Component already exists on entity")

	local system = self.world:getSystem(name)
	self.components[name] = data
	self.disabledComponents[name] = nil
	system:addComponent(self, data)
end

function Entity:addDisabledComponent(name, data)
	assert(self.components[name] == nil, "Component already exists on entity")

	local system = self.world:getSystem(name)
	self.disabledComponents[name] = data
end

function Entity:removeComponent(name)
	self.disabledComponents[name] = nil
	if self.components[name] then
		local system = self.world:getSystem(name)
		system:removeComponent(self)
		self.components[name] = nil
	end
end

function Entity:removeAllComponents()
	for name,data in pairs(self.components) do
		self:removeComponent(name)
	end
end

function Entity:onRemove()
end

function Entity:disableComponent(name)
	local component = self.components[name]
	if component then
		self:removeComponent(name)
		self.disabledComponents[name] = component
	end
end

function Entity:enableComponent(name)
	local component = self.disabledComponents[name]
	self:addComponent(name, component)
end

function Entity:disableAllComponents()
	for name, _ in pairs(self.components) do
		self:disableComponent(name)
	end
end

function Entity:enableAllComponents()
	for name, _ in pairs(self.disabledComponents) do
		self:enableComponent(name)
	end
end

return Entity
