local switches = require("data.switches")

local loaders = {
	player = function(world, object)
		local ent = world:addEntity(require("entities.player"))

		ent:addComponent("position", object.center:clone())
		ent:addComponent("mortal", {
			alive = true
		})
		ent:addComponent("collision", {
			position = ent:getComponent("position"):clone(),
			width = 20,
			height = 20,
			solid = true
		})

	end,

	switch = function(world, object)
		local ent = world:addEntity(require("entities.switch"))

		ent:addComponent("position", object.center:clone())
		ent:addComponent("switch", switches[object.name])
	end,

	snatcher = function(world, object)
		local ent = world:addEntity(require("entities.snatcher"), object.center:clone())
	end
}

local function loadMap(world)
	local map = dofile("assets/maps/main.lua")

	local mapObjects = {}

	for _, layer in ipairs(map.layers) do
		if layer.type == "objectgroup" then
			for _, object in ipairs(layer.objects) do
				-- Make convient object
				local center = Vector(object.x, object.y) + (Vector(object.width, object.height) / 2)
				local obj = {
					id = object.id,
					name = object.name,
					type = object.type,
					center = center,
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
