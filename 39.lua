-- result: 840
-- time: 0.1s
--
-- If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.
-- 
-- {20,48,52}, {24,45,51}, {30,40,50}
-- 
-- For which value of p ≤ 1000, is the number of solutions maximised?

local maxp = {}
local p = 1000
for a = 1, p/2 do
  for b = 1, a do
    local c2 = a*a + b*b
    c = math.floor(math.sqrt(c2))
    local i = a+b+c
    if i <= p and c * c == a*a + b*b then
      -- print(a, b, c, a+b+c)
      if maxp[i]==nil then
        maxp[i] = 1
      else
        maxp[i] = 1 + maxp[i]
      end
    end
  end
end

local m = 0
for k, v in pairs(maxp) do
  -- print(k, v)
  if v > m then
    print(k, v)
    m = v
  end
end
