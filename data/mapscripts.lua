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
		world:getSystem("colorrender"):disable()
		world:enableTaggedEntities("colorSwitch_walls")
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

			if object.raw.properties.special == "sprinter" then
				local followerai = ent:getComponent("followerai")
				followerai.nextSprint = 0.5
			end

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
			if object.tag then
				world:tagEntity(ent, object.tag)
			end
		end,

		line = function(world, object)
			local ent = world:addEntity(require("entities.line"), object.points)
			if object.tag then
				world:tagEntity(ent, object.tag)
			end
		end,

		color = function(world, object)
			local ent = world:addEntity(require("entities.color"), object.name, object.points)
			if object.tag then
				world:tagEntity(ent, object.tag)
			end
		end,

		barrier = function(world, object)
			local ent = world:addEntity(require("entities.barrier"), object.center, object.rect)
			if object.tag then
				world:tagEntity(ent, object.tag)
			end
		end,

		gate = function(world, object)
			local ent = world:addEntity(require("entities.gate"), object.rect, object.name)
			world:addBookmark(object.name, ent)
			if object.tag then
				world:tagEntity(ent, object.tag)
			end
		end

	}
}
