local Camera = require("lib.hump.camera")

local CameraSystem = require("system"):extend()

function CameraSystem:init(...)
	CameraSystem.super.init(self, ...)

	self.camera = Camera.new(0, 0)
	self:updateCamera() -- Update camera if able to
end

function CameraSystem:execute(dt)
	self:updateCamera(dt)
end

function CameraSystem:getCamera()
	return self.camera
end

function CameraSystem:updateCamera()
	local player = self.world:getBookmark("player")
	if player == nil then return end

	local playercomp = player:composeComponents("position")

	self.camera:lookAt(playercomp.position:unpack())
end

return CameraSystem
