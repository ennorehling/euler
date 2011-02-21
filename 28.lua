-- c(i) := 4 * (i+1)
-- t(i) := (i*2+1)*(i*2+1)
-- a9(i) := t(i)
-- a7(i) := t(i) - 2*i
-- a5(i) := t(i) - 4*i
-- a3(i) := t(i) - 6*i

function t(i) return (i*2+1)*(i*2+1) end

local i
local d1, d2 = 0, 0
for i=1,500 do
  d1 = d1 + 2 * t(i) - 4*i
  d2 = d2 + 2 * t(i) - 8*i
end
print(d1+d2+1)
