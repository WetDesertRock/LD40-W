local Text = require("entity"):extend()

function Text:init()
	Text.super.init(self)

	-- self:addComponent("position", Vector(0,300))
	-- self:addComponent("textrender", {
	-- 	text = "Press space",
	-- 	limit = love.graphics.getWidth(),
	-- 	align = "center",
	-- 	font = "Rounded_Elegance.ttf",
	-- 	fontsize = 64
	-- })
  --
	-- self.world:addBookmark("graphicsSwitch_text", self)
end

return Text
