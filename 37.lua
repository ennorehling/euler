-- result: 748317
-- time:
-- The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.
-- 
-- Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
-- NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

require "euler"

local MAX = 1000000
primes, prime_table = sieve_primes(MAX)

function test(n)
  local s = tostring(n)
  local sl = string.len(s)
  for i=1,sl do
    -- print(s, string.sub(s, i, sl))
    local k = tonumber(string.sub(s, i, sl))
    if not isprime(k, prime_table) then return 0 end
  end
  for i=1,sl do
    local k = tonumber(string.sub(s, 1, i))
    if not isprime(k, prime_table) then return 0 end
  end
  return n
end

assert(test(3797)==3797)
assert(test(3798)==0)

local sum, m = 0, 0
local i = 5
while m<11 do
  local p = primes[i]
  local t = test(p)
  if t>0 then
    sum = sum + t
    m = m + 1
    print(p)
  end
  i = i + 1
end
print(sum)
