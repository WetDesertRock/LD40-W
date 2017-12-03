return {
	graphicsSwitch = {
		data = {
			id = "graphicsSwitch",
			title = "G",
			sticky = true,
			state = false
		},

		enable = function(self, switch)
			-- Enable world renderer
			local worldRenderer = self.world:getSystem("worldrender")
			worldRenderer:enable()

			-- Disable "Press button" text
			local text = self.world:getBookmark("graphicsSwitch_text")
			if text then
				self.world:removeEntity(text)
			end

			-- Add playermovement
			local player = self.world:getBookmark("player")
			player:addComponent("playermovement", {})

			-- Enable followers
			-- local followers = self.world:getTaggedEntities("followers")
			-- for _,follower in ipairs(followers) do
			-- 	follower:enableAllComponents()
			-- end
			local playerpos = player:getComponent("position")
			self.world:getSystem("followerspawner"):spawn(30)
		end,

		disable = function(self, switch) end -- Sticky switch
	}
}
