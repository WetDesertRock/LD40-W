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

	snatcher = function(self, entity)
		local compo = entity:composeComponents("position", "snatchereye")

		love.graphics.setColor(50, 20, 20)
		love.graphics.circle("fill", compo.position.x, compo.position.y, 8, 15)

		local epos = (compo.snatchereye.direction * 4) + compo.position
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle("line", epos.x, epos.y, 3)
	end,

	switch = function(self, entity)
		local compo = entity:composeComponents("position", "switch")

		local size = Vector(20, 30)
		local sx,sy = (compo.position - size / 2):unpack()

		love.graphics.setColor(20, 20, 120)
		love.graphics.rectangle("fill", sx,sy, size.x,size.y, 10)

		-- Draw switch indicator
		local offset = Vector(0, 8)
		if compo.switch.state then
			offset = offset * -1
		end

		local x,y = (compo.position + offset):unpack()
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle("line", x,y, 6)

		-- Draw name
		local x,y = (compo.position + Vector(-32, 24)):unpack()
		local limit = 64
		local font = Media:getFont("Rounded_Elegance.ttf", 40)

		love.graphics.setColor(20, 20, 120)
		love.graphics.setFont(font)
		love.graphics.printf(compo.switch.title, x,y, limit, "center")
	end,

	wall = function(self, entity)
		local rect = entity:getComponent("rectangle")
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("fill", rect:unpack())
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

local WorldRender = require("timingsystem"):extend()

function WorldRender:init(...)
	WorldRender.super.init(self, ...)
	self.enabled = false
	self.fade = 1

	self.camera = Camera.new(0, 0)
	self:updateCamera() -- Update camera if able to
end

function WorldRender:enable()
	if self.enabled then return end

	self.tweens:to(self, 3, {fade=0})

	WorldRender.super.enable(self)
end


function WorldRender:execute()
	WorldRender.super.execute(self)
	if not self.enabled then return end

	self:updateCamera()

	self.camera:attach()

	for uuid, data in pairs(self.components) do
		local entity = self.world:getEntity(uuid)

		-- Render the entity
		renderers[data](self, entity)

		-- Render debug info
		-- renderers.debug(self, entity)
	end

	self.camera:detach()

	if self.fade ~= 0 then
		love.graphics.setColor(255, 255, 255, 255*self.fade)
		love.graphics.rectangle("fill", 0,0, love.graphics.getWidth(), love.graphics.getHeight())
	end
end

function WorldRender:updateCamera()
	local player = self.world:getBookmark("player")
	if player == nil then return end

	local playercomp = player:composeComponents("position")

	self.camera:lookAt(playercomp.position:unpack())
end

return WorldRender
