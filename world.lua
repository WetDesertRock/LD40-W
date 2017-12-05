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

function World:getSystem(name)
	local system = self.systems[name]
	assert(system ~= nil, "Could not find system: "..name)
	return system
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

	self.tags[tag][entity.uuid] = entity
end

function World:getTaggedEntities(tag)
	if self.tags[tag] == nil then
		self.tags[tag] = {}
	end

	return self.tags[tag]
end

function World:enableTaggedEntities(tag)
	if self.tags[tag] == nil then
		self.tags[tag] = {}
	end

	for _,ent in pairs(self.tags[tag]) do
		ent:enableAllComponents()
	end
end


function World:removeEntity(entity)
	print("Removing entity", entity.uuid)
	entity:removeAllComponents()
	self.entities[entity.uuid] = nil
	entity:onRemove()

	for _, entities in pairs(self.tags) do
		entities[entity.uuid] = nil
	end
end

function World:removeBookmark(name)
	self.bookmarks[name] = nil
end

return World
