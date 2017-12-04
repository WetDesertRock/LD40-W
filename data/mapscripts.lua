return {
	init = function(world)
		-- Load objects not loaded at start
		local ent = world:addEntity(require("entities.text"))
		ent:addComponent("position", Vector(0,300))
		ent:addComponent("textrender", {
			text = "Press space",
			limit = love.graphics.getWidth(),
			align = "center",
			font = "Rounded_Elegance.ttf",
			fontsize = 64
		})

		world:addBookmark("graphicsSwitch_text", ent)


		--- Set initial states of systems
		world:getSystem("linerender"):disable()
		world:getSystem("soundsystem"):disable()
	end,
	loaders = {
		player = function(world, object)
			local ent = world:addEntity(require("entities.player"), object.center)

			if object.tag then
				world:tagEntity(ent, object.tag)
			end
		end,

		switch = function(world, object)
			local ent = world:addEntity(require("entities.switch"), object.center, object.name)

			if object.tag then
				world:tagEntity(ent, object.tag)
			end
		end,

		follower = function(world, object)
			local ent = world:addEntity(require("entities.follower"), object.center)
			if object.tag then
				ent:disableAllComponents()
				world:tagEntity(ent, object.tag)
			end
		end,

		snatcher = function(world, object)
			local ent = world:addEntity(require("entities.snatcher"), object.center)
			if object.tag then
				ent:disableAllComponents()
				world:tagEntity(ent, object.tag)
			end
		end,

		wall = function(world, object)
			local ent = world:addEntity(require("entities.wall"), object.center, object.rect)
		end,

		line = function(world, object)
			local ent = world:addEntity(require("entities.line"), object.points)
		end,

		barrier = function(world, object)
			local ent = world:addEntity(require("entities.barrier"), object.center, object.rect)
		end

	}
}
