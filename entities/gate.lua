local gates = require("data.gates")

local Gate = require("entity"):extend()

function Gate:init(rect, id)
	assert(gates[id] ~= nil, "Unknown gate ID: "..id)

	self:addComponent("rectangle", rect:clone())

	self:addComponent("collision", {
		position = Vector(rect:middle()),
		width = rect.width,
		height = rect.height,
		solid = true
	})

	self:addComponent("gaterender", gates[id])
end

return Gate
