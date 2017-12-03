local World = Object:extend()

function World:new()
	self.entities = {}
	self.systems = {}
	self.bookmarks = {}
	self.tags = {}
end

function World:addSystem(name)
	self.systems[name] = require("systems."..name)(self)
	self.systems[name]:init(self)
end

function World:addSystems(...)
	for _, name in ipairs({...}) do
		self:addSystem(name)
	end
end

function World:addEntity(cls, ...)
	-- Create entity from given class
	local entity = cls(self)

	-- Add it and run init
	self.entities[entity.uuid] = entity
	entity:init(...)

	return entity
end

function World:addBookmark(name, entity)
	self.bookmarks[name] = entity
end

function World:executeSystem(system, ...)
	self.systems[system]:execute(...)
end

function World:executeSystems(...)
	local systems = {...}
	return function(...)
		for _, system in ipairs(systems) do
			self:executeSystem(system, ...)
		end
	end
end

function World:getSystem(system)
	return self.systems[system]
end

function World:getEntity(uuid)
	return self.entities[uuid]
end

function World:getBookmark(name)
	return self.bookmarks[name]
end

function World:tagEntity(entity, tag)
	if self.tags[tag] == nil then
		self.tags[tag] = {}
	end

	table.insert(self.tags[tag], entity)
end

function World:getTaggedEntities(tag)
	if self.tags[tag] == nil then
		self.tags[tag] = {}
	end

	return self.tags[tag]
end

function World:removeEntity(entity)
	entity:removeAllComponents()
	self.entities[entity.uuid] = nil
	entity:onRemove()
end

function World:removeBookmark(name)
	self.bookmarks[name] = nil
end

return World
