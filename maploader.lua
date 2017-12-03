local loaders = {
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
		ent:disableAllComponents()
		if object.tag then
			world:tagEntity(ent, object.tag)
		end
	end,

	snatcher = function(world, object)
		local ent = world:addEntity(require("entities.snatcher"), object.center)
		ent:disableAllComponents()
		if object.tag then
			world:tagEntity(ent, object.tag)
		end
	end,

	wall = function(world, object)
		local ent = world:addEntity(require("entities.wall"), object.center, object.rect)
	end
}

local function loadMap(world)
	local map = dofile("assets/maps/main.lua")

	local mapObjects = {}

	for _, layer in ipairs(map.layers) do
		if layer.type == "objectgroup" then
			for _, object in ipairs(layer.objects) do
				-- Make convient object
				local rect = Rect(object.x, object.y, object.width, object.height)
				local center = Vector(rect:middle())
				local obj = {
					id = object.id,
					name = object.name,
					type = object.type,
					center = center,
					tag = object.properties.tag,
					rect = rect,
					raw = object
				}
				table.insert(mapObjects, obj)
			end
		end
	end

	for _, object in ipairs(mapObjects) do
		local loader = loaders[object.type]
		if loader == nil then
			print(string.format("WARNING: loader is nil for type %s (id %d)", object.type, object.id))
		else
			loader(world, object)
		end
	end

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
end


return loadMap
