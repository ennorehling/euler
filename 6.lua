local a
local n = 100
local sum = (n+1)*n/2
sum = sum * sum

local sqr = 0
for a=1,n do
  sqr = sqr + a*a
end
print (sum, sqr, sum-sqr)