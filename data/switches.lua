return {
	graphicsSwitch = {
		data = {
			id = "graphicsSwitch",
			title = "G",
			sticky = true,
			state = false
		},

		enable = function(self, switch)
			-- Fade in
			print("fading")
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
		end,

		disable = function(self, switch) end -- Sticky switch
	},
	linesSwitch = {
		data = {
			id = "linesSwitch",
			title = "L",
			sticky = false,
			state = false
		},

		enable = function(self, switch)
			-- Kill all followers:
			self.world:getSystem("followerai"):killAllFollowers()

			-- Enable followers
			self.world:enableTaggedEntities("linesSwitch_enemies")
			self.world:getSystem("followerspawner"):spawn(5)
		end,

		disable = function(self, switch) end -- Sticky switch
	}
}
