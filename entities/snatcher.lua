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

	self:addComponent("snatcherai", {
		origin = position:clone(),
		cooldown = 0,
		range = 50
	})
	self:addComponent("snatcherrender", {
		direction = Vector.fromAngleMag(love.math.random() * math.pi * 2, 1),
		phaseShift = love.math.random()
	})
	self:addComponent("soundsystem", {
		volume = 0.5,
		file = "LD40_Snatcher.ogg",
		maxdist = 100
	})
end

function Snatcher:onDeath()
	self.world:removeEntity(self)
end


return Snatcher
