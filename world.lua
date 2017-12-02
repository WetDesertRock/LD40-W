local World = Object:extend()

function World:new()
	self.entities = {}
	self.systems = {}
	self.bookmarks = {}
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

function World:addEntity(entity, ...)
	self.entities[entity.uuid] = entity
	entity:init(self, ...)
end

function World:addBookmark(name, entity)
	self.bookmarks[name] = entity
end

function World:executeSystem(system, ...)
	self.systems[system]:execute(...)
end

function World:executeSystems(...)
	for _, system in ipairs({...}) do
		self:executeSystem(system)
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

function World:removeEntity(entity)
	entity:removeAllComponents()
	self.entities[name] = nil
	entity:onRemove()
end

function World:removeBookmark(name)
	self.bookmarks[name] = nil
end

return World
