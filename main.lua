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
		"render",
		"collision",
		"mortal"
	)

	local ent = require("entities.player")()
	world:addEntity(ent)

	local ent = require("entities.follower")()
	world:addEntity(ent)
end

function love.update(dt)
	world:executeSystem("playermovement", dt)
	world:executeSystem("followermovement", dt)
	world:executeSystem("collision", dt)
	world:executeSystem("mortal", dt)
end

function love.draw()
	love.graphics.setBackgroundColor(240, 240, 240)
	world:executeSystem("render")
end
