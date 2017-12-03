local TextRender = require("system"):extend()

function TextRender:execute(dt)
	if not self.enabled then return end

	for uuid, data in pairs(self.components) do
		local comp = self:composeComponents(uuid, "position", "textrender")

		local x,y = comp.position:unpack()
		local text = comp.textrender.text
		local limit = comp.textrender.limit
		local align = comp.textrender.align
		local fontface = comp.textrender.font
		local fontsize = comp.textrender.fontsize

		local font = Media:getFont(fontface, fontsize)

		love.graphics.setFont(font)
		love.graphics.setColor(0,0,0)
		love.graphics.printf(text, x,y, limit, align)

	end
end

return TextRender
