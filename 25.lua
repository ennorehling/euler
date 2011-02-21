require("BigNum")

local c = BigNum.new()
local a = BigNum.new(1)
local b = BigNum.new(1)
local i = 2
for i=3,10000 do
  BigNum.add(b, a, c)
  local t = a
  a = b
  b = c
  c = t
  if (string.len(tostring(b))>=1000) then
    print(i, b)
    break
  end
end
