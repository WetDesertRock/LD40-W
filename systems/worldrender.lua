local Camera = require("lib.hump.camera")

local renderers = {
	player = function(self, entity)
		local compo = entity:composeComponents("position")

		love.graphics.setColor(20, 20, 20)
		love.graphics.circle("fill", compo.position.x, compo.position.y, 10, 15)
	end,

	enemy = function(self, entity)
		local compo = entity:composeComponents("position")

		love.graphics.setColor(50, 20, 20)
		love.graphics.circle("fill", compo.position.x, compo.position.y, 10, 15)
	end,

	switch = function(self, entity)
		local compo = entity:composeComponents("position", "switch")

		local size = Vector(16, 24)
		local sx,sy = (compo.position - size / 2):unpack()

		love.graphics.setColor(20, 20, 50)
		love.graphics.rectangle("fill", sx,sy, size.x,size.y, 7)

		-- Draw switch indicator
		local offset = Vector(0, -5)
		if compo.switch.state then
			offset = offset * -1
		end

		local x,y = (compo.position + offset):unpack()
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle("line", x,y, 4)
	end,

	debug = function(self, entity)
		local compo = entity:composeComponents("position", "collision")

		if compo.collision then
			local x,y = compo.collision.position:unpack()

			love.graphics.setColor(255,0,0)
			love.graphics.rectangle("line", x,y, compo.collision.width, compo.collision.height)
		end
	end,
}

local WorldRender = require("system"):extend()

function WorldRender:init(...)
	WorldRender.super.init(self, ...)

	self.camera = Camera.new(0, 0)
	self:updateCamera() -- Update camera if able to
end

function WorldRender:execute(dt)
	if not self.enabled then return end

	self:updateCamera()

	self.camera:attach()

	for uuid, data in pairs(self.components) do
		local entity = self.world:getEntity(uuid)

		-- Render the entity
		renderers[data](self, entity)

		-- Render debug info
		renderers.debug(self, entity)
	end

	self.camera:detach()
end

function WorldRender:updateCamera()
	local player = self.world:getBookmark("player")
	if player == nil then return end

	local playercomp = player:composeComponents("position")

	self.camera:lookAt(playercomp.position:unpack())
end

return WorldRender
