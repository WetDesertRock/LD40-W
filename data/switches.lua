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
		enable = function(self, switch) end,
		disable = function(self, switch) end
	},
}
