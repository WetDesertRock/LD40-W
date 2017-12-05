-- Set up globals
Object = require("lib.classic")
lume = require("lib.lume")
coil = require("lib.coil")
flux = require("lib.flux")
Media = require("lib.mediamanager")
Rect = require("lib.rectangle")
Vector = require("lib.vector")

SwitchStates = {
	sound = false
}

-- Watch out for globals
require("lib.globalwatch")

local world = require("world")()
local mapLoader = require("maploader")

function love.load()
	Media:preloadSounds()
	Media:preloadImages()
	world:addSystems(
		"position",
		"checkpoint",
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
		"linerender",
		"barrierrender",
		"colorrender",
		"gaterender",
		"soundsystem",
		"camera"
	)

	mapLoader(world)

	local src = Media:playSound("LD40_Ambient.ogg", 0.03)
	src:setLooping(1)
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
		"soundsystem",
		"mortal",
		"camera"
	)(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(240, 240, 240)
	world:executeSystems(
		"colorrender",
		"barrierrender",
		"linerender",
		"gaterender",
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
