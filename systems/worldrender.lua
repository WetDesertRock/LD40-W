local Camera = require("lib.hump.camera")

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
		local compo = self:composeComponents(uuid, "position", "collision")

		local offX,offY = 0,0

		if compo.collision then
			offX = compo.collision.width/2
			offY = compo.collision.height/2
		end

		love.graphics.setColor(20, 20, 20)
		love.graphics.circle("fill", compo.position.x + offX, compo.position.y + offY, 10, 15)
	end

	self.camera:detach()
end

function WorldRender:updateCamera()
	local player = self.world:getBookmark("player")
	if player == nil then return end

	local playercomp = player:composeComponents("position", "collision")

	if playercomp.collision == nil then return end

	local offX = playercomp.collision.width/2
	local offY = playercomp.collision.height/2

	local cx,cy = playercomp.position.x + offX, playercomp.position.y + offY

	self.camera:lookAt(cx, cy)
end

return WorldRender
