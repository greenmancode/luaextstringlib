-- Lua Extended String Library (Roblox Lua edition)
-- This version is made for Roblox exploits
-- Written by Greenman

setreadonly(string,false)

string.charCodeAt = function(self,idx)
  return self:byte(idx,idx)
end

string.concat = function(self, str2)
  return self..str2
end

string.endsWith = function(self, p)
  return self:gmatch(p.."$")() ~= nil
end

string.includes = function(self,p,s)
  return self:find(p,s or 1) ~= nil
end

string.split = function(self,p)
  local t = {}
  if p == nil then p = "%s" end
  for x in self:gmatch("([^"..p.."]+)") do
    table.insert(t,x)
  end
  return t
end

string.indexOf = function(self,p,s)
  local idx = self:find(p,s)
  return idx or -1
end

-- currently broken
--[[
string.lastIndexOf = function(self,p,s)
  for i=s or #self, 1, -1 do
    if self:find(p,i) ~= nil then
      return i
    end
  end
end
]]--

string.startsWith = function(self,p)
  return self:gmatch("^"..p)() ~= nil
end

string.trim = function(self)
  self = self:gsub("^%s+","")
  self = self:gsub("%s+$","")
  return self
end

local oldstr = string
local index = getrawmetatable('').__index
setreadonly(index, false)
index = newcclosure(function(str,key)
  if type(key) == "number" then
    return oldstr.sub(str,key,key)
  else
    return oldstr[key]
  end
end)

getrawmetatable('').__call = newcclosure(function(self,...)
  local args = {...}
  if type(args[1]) == "number" and type(args[2]) == "number" then
    return self:sub(args[1],args[2])
  end
end)
