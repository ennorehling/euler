-- result: 997651

require "euler"

m=0
primes, prime_table = sieve_primes(1000000)

local plen = 0
local pnum = 1
local psum = 2 -- sum of primes[1..ptop]
for k, p in ipairs(primes) do
  if psum<p then
    pnum = pnum + 1
    psum = psum + primes[pnum]
  end
  local pmax = pnum
  local pmin = 1
  local sum = psum
  while pmax<k do
    if k-pmin<plen then break end
    if primes[pmin]*plen>p then break end
    while sum<p do
      pmax = pmax + 1
      sum = sum + primes[pmax]
    end
    while sum>p do
      sum = sum - primes[pmin]
      pmin = pmin +1
    end
    if sum==p then
      if pmax-pmin > plen then
        plen = pmax-pmin
        m = p
        -- print(p, pmin, pmax)
      end
      break
    end
  end
end
print(m)
