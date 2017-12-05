return {
	graphicsSwitch = {
		data = {
			id = "graphicsSwitch",
			title = "G",
			sticky = false,
			state = false
		},

		enable = function(self, switch)
			if not switch.triggered then
				-- Fade in
				self.world:getSystem("faderender"):fadeIn(3)

				-- Disable "Press button" text
				local text = self.world:getBookmark("graphicsSwitch_text")
				if text then
					self.world:removeEntity(text)
				end

				-- Add playermovement
				local player = self.world:getBookmark("player")
				player:addComponent("playermovement", {})

				-- Enable followers
				self.world:enableTaggedEntities("graphicsSwitch_followers")
				self.world:getSystem("followerspawner"):spawn(20)
			end

			self.world:getBookmark("graphicsGate"):disableAllComponents()
		end,

		disable = function(self, switch)
			self.world:getBookmark("graphicsGate"):enableAllComponents()
		end
	},
	linesSwitch = {
		data = {
			id = "linesSwitch",
			title = "L",
			sticky = false,
			state = false
		},

		enable = function(self, switch)
			if not switch.triggered then
				-- Kill all followers:
				self.world:getSystem("followerai"):killAllFollowers()
				self.world:getSystem("faderender"):flash()

				-- Enable followers
				self.world:enableTaggedEntities("linesSwitch_enemies")
				self.world:getSystem("followerspawner"):spawn(5)
			end
			self.world:getSystem("linerender"):enable()
			self.world:getBookmark("linesGate"):disableAllComponents()
		end,

		disable = function(self, switch)
			self.world:getSystem("linerender"):disable()
			self.world:getBookmark("linesGate"):enableAllComponents()
		end
	},
	soundSwitch = {
		data = {
			id = "soundSwitch",
			title = "S",
			sticky = false,
			state = false
		},
		enable = function(self, switch)
			if not switch.triggered then
				-- Enable demo of sprinting:
				self.world:enableTaggedEntities("soundSwitch_enemies")
			end

			self.world:getSystem("soundsystem"):enable()
			self.world:getSystem("followerai"):setSprintable(true)
			self.world:getBookmark("soundGate"):disableAllComponents()
		end,
		disable = function(self, switch)
			self.world:getSystem("soundsystem"):disable()
			self.world:getSystem("followerai"):setSprintable(false)
			self.world:getBookmark("soundGate"):enableAllComponents()
		end
	},
	pathingSwitch = {
		data = {
			id = "pathingSwitch",
			title = "P",
			sticky = false,
			state = false
		},
		enable = function(self, switch) end,
		disable = function(self, switch) end
	},
	colorSwitch = {
		data = {
			id = "colorSwitch",
			title = "C",
			sticky = false,
			state = false
		},
		enable = function(self, switch)
			self.world:getSystem("colorrender"):enable()
			self.world:getSystem("followerspawner"):setSpawnRange(300, 1000)
			self.world:getBookmark("colorGate"):disableAllComponents()
			self.world:disableTaggedEntities("colorSwitch_walls")
		end,
		disable = function(self, switch)
			self.world:getSystem("colorrender"):disable()
			self.world:getSystem("followerspawner"):setSpawnRange(750, 1000)
			self.world:getBookmark("colorGate"):enableAllComponents()
			self.world:enableTaggedEntities("colorSwitch_walls")
		end
	},
	finalSwitch = {
		data = {
			id = "finalSwitch",
			title = "-",
			sticky = true,
			state = false
		},
		enable = function(self, switch)
			self.world:getSystem("faderender"):fadeOut(5)
			self.world:getSystem("soundsystem"):fadeOut(8)


			local player = self.world:getBookmark("player")
			player:removeComponent("collision")
			player:removeComponent("playermovement")

			-- Add done text
			local ent = self.world:addEntity(require("entities.text"))
			ent:addComponent("position", Vector(0,200))
			ent:addComponent("textrender", {
				text = "M",
				limit = love.graphics.getWidth(),
				align = "center",
				font = "Rounded_Elegance.ttf",
				fontsize = 120
			})
			local ent = self.world:addEntity(require("entities.text"))
			ent:addComponent("position", Vector(0,300))
			ent:addComponent("textrender", {
				text = "-",
				limit = love.graphics.getWidth(),
				align = "center",
				font = "Rounded_Elegance.ttf",
				fontsize = 72
			})
			local ent = self.world:addEntity(require("entities.text"))
			ent:addComponent("position", Vector(0,350))
			ent:addComponent("textrender", {
				text = "end",
				limit = love.graphics.getWidth(),
				align = "center",
				font = "Rounded_Elegance.ttf",
				fontsize = 64
			})
			local ent = self.world:addEntity(require("entities.text"))
			ent:addComponent("position", Vector(0,love.graphics.getHeight()-40))
			ent:addComponent("textrender", {
				text = "@wetdesertrock",
				limit = love.graphics.getWidth()-20,
				align = "right",
				font = "Rounded_Elegance.ttf",
				fontsize = 24
			})
		end,
		disable = function(self, switch) end --sticky
	},
}
