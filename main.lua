-- Set up globals
Object = require("lib.classic")
lume = require("lib.lume")
coil = require("lib.coil")
Media = require("lib.mediamanager")
Vector = require("lib.vector")

-- Watch out for globals
require("lib.globalwatch")

local world = require("world")()
local mapLoader = require("maploader")

function love.load()
	world:addSystems(
		"position",
		"movement",
		"playermovement",
		"followermovement",
		"worldrender",
		"collision",
		"switch",
		"input",
		"textrender",
		"snatchereye",
		"snatcherai",
		"mortal"
	)

	mapLoader(world)
end

function love.update(dt)
	world:executeSystems(
		"input",
		"playermovement",
		"switch",
		"followermovement",
		"collision",
		"snatchereye",
		"snatcherai",
		"mortal"
	)(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(240, 240, 240)
	world:executeSystem("worldrender")
	world:executeSystem("textrender")
end
