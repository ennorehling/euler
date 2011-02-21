local primes = {}
local mx = 2000000

local sum = 0
local n = 2
while n<mx do
  sum = sum + n
  local x = n*2
  while x<mx do
    primes[x] = false
    x=x+n
  end
  n = n + 1
  while n<mx and primes[n]==false do n = n + 1 end
end
print(n, sum)
