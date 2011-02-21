-- result: 76576500
-- time:   1.159s

-- composites = { }
-- maxc = 0

function prime_divisors(i, primes)
  local b = {}
  local bi = 0
  local r = i
  local pi = 0
  while r>1 do
    local p = primes[pi+1]
    local m = 0
    while math.mod(r,p)==0 do
      r = r / p
      m = m + 1
    end
    pi = pi + 1
    b[pi] = m
  end
  return b, pi
end

function sieve_primes(mx)
  local prime = {}
  local primes = { 2 }
  local maxp = 1
  local i
  for i = 3,mx,2 do
    local k = prime[(i-1)/2]
    if k==nil then
      maxp = maxp + 1
      primes[maxp] = i
      local x
      for x = i*3,mx,i*2 do
        prime[(x-1)/2] = false
      end
    end
  end
  return primes, prime
end

function isprime(p, prime_table)
  if p<=2 then
    return p==2
  end
  if math.mod(p,2)==0 then
    return false
  end
  -- return composites[(p-1)/2]==nil
  return prime_table[(p-1)/2]==nil
end

