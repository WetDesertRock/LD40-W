-- Set up globals
Object = require("lib.classic")
lume = require("lib.lume")
Media = require("lib.mediamanager")
Rect = require("lib.rectangle")
Vector = require("lib.vector")

-- Watch out for globals
require("lib.globalwatch")

local world = require("world")()

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
		"mortal"
	)

	local ent = require("entities.player")()
	world:addEntity(ent)

	-- local ent = require("entities.follower")()
	-- world:addEntity(ent)

	local ent = require("entities.switch")()
	world:addEntity(ent)
end

function love.update(dt)
	world:executeSystems(
		"input",
		"playermovement",
		"switch",
		"followermovement",
		"collision",
		"mortal"
	)(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(240, 240, 240)
	world:executeSystem("worldrender")
end
