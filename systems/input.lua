local baton = require("lib.baton")

local InputSystem = require("system"):extend()

function InputSystem:init(...)
	InputSystem.super.init(self, ...)

	self.input = baton.new(require("bindings"))
end

function InputSystem:execute(dt)
	if not self.enabled then return end

	self.input:update(dt)
end

function InputSystem:getInput()
	return self.input
end

return InputSystem
