local primes = {}
local i
local mx = 1000000

local p = 1
local n = 2
while p<10001 do
  local x = n*2
  while x<mx do
    primes[x] = false
    x=x+n
  end
  n = n + 1
  while primes[n]==false do n = n + 1 end
  p = p + 1
end
print(n)
