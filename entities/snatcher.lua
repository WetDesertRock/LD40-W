local Snatcher = require("entity"):extend()


function Snatcher:init(position)
	self:addComponent("position", position:clone())
	self:addComponent("movement", {
		speed = 300,
		direction = 0
	})
	self:addComponent("mortal", {
		alive = true
	})
	self:addComponent("worldrender", "snatcher")

	self:addComponent("snatcherai", {
		origin = position:clone(),
		cooldown = 0,
		range = 50
	})
	self:addComponent("snatchereye", {
		direction = Vector(1,0),
		phaseShift = love.math.random()
	})
end

function Snatcher:onDeath()
	self.world:removeEntity(self)
end


return Snatcher