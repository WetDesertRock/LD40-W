local Object = require("lib.classic")
local lume = require("lib.lume")

local MediaManager = Object:extend()

local imageformats = {
  ".bmp", ".hdr", ".gif", ".jpg", ".jpeg",
  ".ibm", ".png", ".raw", ".tga", ".tif"
}

local audioformats = {
  ".wav", ".ogg", ".mp3",
  ".699", ".abc", ".amf", ".ams", ".dbm", ".dmf",
  ".dsm", ".far", ".it", ".j2b", ".mdl", ".med",
  ".mid", ".mod", ".mt2", ".mtm", ".okt", ".pat",
  ".psm", ".s3m", ".stm", ".ult", ".umx", ".xm"
}
local function endswith(s,n)
  return n=='' or string.sub(s,-string.len(n))==n
end


function MediaManager:new()
  self:purge()
  self.pre = ""
end

function MediaManager:setPrefix(pre)
  self.pre = pre or ""
end

function MediaManager:getImage(path, fn)
  path = self.pre.."/assets/images/"..path
  if self.graphics[path] == nil then
    if fn then
      local idata = love.image.newImageData(path)
      idata:mapPixel(fn)
      self.graphics[path] = love.graphics.newImage(idata)
    else
      self.graphics[path] = love.graphics.newImage( path )
    end
  end
  return self.graphics[path]
end

function MediaManager:getAnimation(name)
  local optspath = string.format("assets/animations/%s",name)
  if self.animations[name] == nil then
  local opts = require(optspath)
  opts.image = self:getImage( opts.image )
  if not opts.frames then
    opts.frames = opts.image:getWidth()/opts.width
  end
  if not opts.delay then
    opts.delay = 1000
  end
  self.animations[name] = opts
  end
  return self.animations[name]
end

function MediaManager:getFont(path,size)
  path = self.pre.."assets/fonts/"..path
  local fpath = tostring(size)..path
  if self.fonts[fpath] == nil then
    self.fonts[fpath] = love.graphics.newFont( path,size )
  end
  return self.fonts[fpath]
end

function MediaManager:getSound(path)
  path = self.pre.."/assets/sounds/"..path
  if self.sounds[path] == nil then
    self.sounds[path] = love.audio.newSource( path,"static" )
  end
  return self.sounds[path]:clone()
end

function MediaManager:playSound(path,volume,pitch,pos)
  local snd = self:getSound(path)
  if volume ~= nil then
    snd:setVolume(volume)
  end
  if pitch ~= nil then
    snd:setPitch(pitch)
  end
  if pos ~= nil then
    snd:setPosition( pos.x,pos.y,1 )
    snd:setRelative( false )
    snd:setAttenuationDistances( 40, 600 )
  else
    -- snd:setPosition( 0,0,1 )
    -- snd:setRelative( true )
  end
  snd:play()

  return snd
end

function MediaManager:playRandSound(snds,volume,pitch,pos)
  return self:playSound(lume.randomchoice(snds),volume,pitch,pos)
end

function MediaManager:getItemCount()
  return getTableLength(self.graphics) + getTableLength(self.fonts) + getTableLength(self.sounds) + getTableLength(self.animations)
end

function MediaManager:purge()
  self.graphics = {}
  self.fonts = {}
  self.sounds = {}
  self.animations = {}
end

function MediaManager:preloadSounds(p)
  local soundfiles = love.filesystem.getDirectoryItems(self.pre.."/assets/sounds/"..(p or ""))
  for k,path in pairs(soundfiles) do
    if lume.any(audioformats,function(s) return endswith(path,s) end) then
      self:getSound((p or "")..path)
      print(string.format("Preloaded: %s",(p or "")..path))
    end
  end
end

function MediaManager:preloadImages(p,fn)
  local imagefiles = love.filesystem.getDirectoryItems(self.pre.."/assets/images/"..(p or ""))
  for k,path in pairs(imagefiles) do
    if lume.any(imageformats,function(s) return endswith(path,s) end) then
      self:getImage((p or "")..path,fn)
      print(string.format("Preloaded: %s",(p or "")..path))
    end
  end
end

return MediaManager()
