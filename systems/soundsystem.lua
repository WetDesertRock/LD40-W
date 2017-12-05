local SoundSystem = require("timingsystem"):extend()

function SoundSystem:init(...)
	SoundSystem.super.init(self, ...)

	self.sources = {}
	self.music = Media:getSound("LD40_Music.ogg")
	self.music:setLooping(1)
	self.music:setVolume(0.2)
	self.music:play()
	love.audio.setDistanceModel("inverse")
end

function SoundSystem:playSound(sound, position)
	if not self.enabled then return end

	if type(sound) == "table" then
		sound = lume.randomchoice(sound)
	end
	local source = Media:getSound(sound)
	source:setRelative(false)
	source:setAttenuationDistances( 16, 1000 )
	source:setPosition(position.x, position.y, 0)
	source:play()

	return source
end

function SoundSystem:onAddComponent(entity, data)
	local position = entity:getComponent("position")
	local source = Media:getSound(data.file)
	local len = source:getDuration("samples")
	source:seek(love.math.random(0, len)) -- Seek to a random point in the source
	source:setLooping(1)
	source:setVolume(1)--data.volume)
	source:setRelative(false)
	source:setAttenuationDistances( 4, 100 )
	if position then
		source:setPosition(position.x, position.y, 0)
	end
	source:play()

	if not self.enabled then
		source:pause()
	end

	self.sources[entity.uuid] = source
end

function SoundSystem:onRemoveComponent(entity, data)
	local source = self.sources[entity.uuid]
	self.tweens:to(data, 0.5, {volume = 0}):onupdate(function()
		source:setVolume(data.volume)
	end):oncomplete(function()
		source:stop()
		self.sources[entity.uuid] = nil
	end)
end

function SoundSystem:enable()
	SoundSystem.super.enable(self)
	for uuid, source in pairs(self.sources) do
		local ent = self.world:getEntity(uuid)
		if ent then
			source:resume()
		else
			-- A source may be fading out (from a component being removal). Just collect that now
			source:stop()
			self.source[entity.uuid] = nil
		end
	end
	self.music:resume()
end

function SoundSystem:disable()
	SoundSystem.super.disable(self)
	for uuid, source in pairs(self.sources) do
		local ent = self.world:getEntity(uuid)
		if ent then
			source:pause()
		else
			-- A source may be fading out (from a component being removal). Just collect that now
			source:stop()
			self.source[entity.uuid] = nil
		end
	end
	self.music:pause()
end

function SoundSystem:execute(dt)
	SoundSystem.super.execute(self, dt)

	local player = self.world:getBookmark("player")
	if player == nil then return end

	local position = player:getComponent("position")

	love.audio.setPosition(position.x, position.y, 0)

	for uuid, source in pairs(self.sources) do
		local ent = self.world:getEntity(uuid)
		if ent then
			local position = ent:getComponent("position")
			if position then
				-- print(position)
				source:setPosition(position.x, position.y, 0)
			end
		end
	end
end

return SoundSystem
