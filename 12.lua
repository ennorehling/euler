-- result: 76576500
-- time:   1.159s

require "euler"

local MAX = 10000
primes, prime_table = sieve_primes(MAX)
print("go!")
local i = 3
local add = 3
local m = 0
while i<MAX*MAX do
  -- local b = {}
  local bm = 1
  -- local bi = 0
  local pi = 1
  local r = i
  while r>1 do
    local p = primes[pi]
    if p*p>i then break end
    local m = 0
    while math.mod(r,p)==0 do
      r = r / p
      m = m + 1
    end
    if m>0 then
      -- bi = bi + 1
      -- b[bi] = m
      bm = bm * (m+1)
    end
    pi = pi + 1
  end
  if bm>m then
    m = bm
    -- print(i, bm)
  end
  if bm>500 then
    print(i, bm)
    break
  end
  i = i + add
  add = add + 1
end
