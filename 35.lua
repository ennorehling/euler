-- result: 55

require "euler"

local m = 0
local primes, prime_table = sieve_primes(1000000)
assert(isprime(971, prime_table))

for k, p in ipairs(primes) do
  s = tostring(p)
  found = true
  sl = string.len(s)
  for rot = 1, sl-1 do
    s = string.sub(s, 2) .. string.sub(s, 1, 1)
    if not isprime(tonumber(s), prime_table) then
      found = false
      break
    end
  end
  if found then m=m+1 end
end
print(m)
