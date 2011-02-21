function is_pandigital(s)
  local b = {}
  for k = 1, 9 do
    local x = string.byte(s, k)-48
    if x==0 or b[x]~=nil then return false end
    b[x] = true
  end
  return true
end

function is_pandigital_n(n)
  local b = {}
  local i
  if n<100000000 then return false end
  for i=1,9 do
    local x = math.mod(n, 10)
    if x==0 or b[x]~=nil then return false end
    b[x] = true
    n = math.floor(n/10)
  end
  return true
end

local a = 0
local b = 1
local c = 1
local k = 2
local gold = (1 + math.sqrt(5))/2
local power = gold * gold
while true do
  local Fk = (power - math.pow(-1, k)/power)/math.sqrt(5)
  if is_pandigital_n(c) then
    local Fk = math.floor((power - math.pow(-1, k)/power)/math.sqrt(5))
    local s = string.format("%10.0f", Fk)
    if is_pandigital(string.sub(s, 1, 9)) then 
      print(s .. ".." .. c, k)
      break
    end
  end
  a = b
  b = c
  c = math.mod(a + b, 1000000000)
  power = power * gold
  while power>10000000000 do power=power/10 end
  k = k + 1
end
