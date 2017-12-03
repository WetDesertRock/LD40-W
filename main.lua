-- Set up globals
Object = require("lib.classic")
lume = require("lib.lume")
coil = require("lib.coil")
flux = require("lib.flux")
Media = require("lib.mediamanager")
Rect = require("lib.rectangle")
Vector = require("lib.vector")

-- Watch out for globals
require("lib.globalwatch")

local world = require("world")()
local mapLoader = require("maploader")

function love.load()
	Media:preloadSounds()
	Media:preloadImages()
	world:addSystems(
		"position",
		"rectangle",
		"movement",
		"playermovement",
		"followermovement",
		"switch",
		"input",
		"snatcherai",
		"followerai",
		"followerspawner",
		"collision",
		"mortal",
		"textrender",
		"playerrender",
		"followerrender",
		"snatcherrender",
		"switchrender",
		"wallrender",
		"faderender",
		"debugrender",
		"camera"
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
		"snatcherai",
		"followerai",
		"followerspawner",
		"mortal",
		"camera"
	)(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(240, 240, 240)
	world:executeSystems(
		"wallrender",
		"switchrender",
		"followerrender",
		"snatcherrender",
		"playerrender",
		-- "debugrender",
		"faderender",
		"textrender"
	)()
end
