-- result: -59231

require "euler"
primes, prime_table = sieve_primes(1000000)
mx = 0

function maxchain(a, b)
  local n, m = 0, 0
  for n = 0, b do
    local x = n * n + a * n + b
    if not isprime(x, prime_table) then
      -- print(a, b, x)
      m = n
      break
    end
  end
  return m
end

assert(isprime(41, prime_table))
-- print(maxchain(1, 41))
assert(maxchain(1, 41)==40)
local a, b, k, aa, ab
local mi = 1000
for a = 1, mi do
  for k, b in primes do
    if b > mi then break end
    local m = maxchain(a, b)
    if m>mx then
      mx = m
      aa = a
      ab = b
    end
    local m = maxchain(a, -b)
    if m>mx then
      mx = m
      aa = a
      ab = -b
    end
    local m = maxchain(-a, b)
    if m>mx then
      mx = m
      aa = -a
      ab = b
    end
    local m = maxchain(-a, -b)
    if m>mx then
      mx = m
      aa = -a
      ab = -b
    end
  end
end
print(aa * ab, mx)
