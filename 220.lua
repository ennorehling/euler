local a = {}
local b = {}
local d = {}

local a1 = {}
a1.rot = 2
a1.x = 1
a1.y = 0
a1.len = 1
a[1] = a1

local b1 = {}
b1.rot = -2
b1.x = -1
b1.y = 0
b1.len = 1
b[1] = b1

local n = 10
local i
for i = 2,n do
  local ai = {}
  local bi = {}
  local ax = a[i-1]
  local bx = b[i-1]
  ai.rot = 2 + ax.rot + bx.rot,4
  ai.len = ax.len + 1 + bx.len
  
  a[i] = ai
  b[i] = bi
end

local n = 50
local x, y = 0, 0
local xof, yof, dir = offset(n-1)
