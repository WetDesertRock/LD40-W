local mt = getmetatable(_G)
if mt == nil then
  mt = {}
  setmetatable(_G, mt)
end

mt.__newindex = function (t, n, v)
  local info = debug.getinfo(2, "Sl")
  print(info.short_src .. ":" .. info.currentline .. ": ".."Assign to global variable "..n)
  rawset(t, n, v)
end
