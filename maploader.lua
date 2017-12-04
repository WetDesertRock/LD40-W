local mapscripts = require("data.mapscripts")

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

				if object.shape == "polyline" then
					obj.type = "line"
					local points = {}
					for _,pt in ipairs(object.polyline) do
						local npt = Vector(pt.x,pt.y) + center
						table.insert(points, npt)
					end
					obj.points = points
				end

				table.insert(mapObjects, obj)
			end
		end
	end

	for _, object in ipairs(mapObjects) do
		local loader = mapscripts.loaders[object.type]
		if loader == nil then
			print(string.format("WARNING: loader is nil for type %s (id %d)", object.type, object.id))
		else
			loader(world, object)
		end
	end

	mapscripts.init(world)
end


return loadMap
