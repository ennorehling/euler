require "euler"

local MAXP = 1000000
primes, prime_table = sieve_primes(MAXP)
assert(isprime(47, prime_table))

local maxpan = 0
used = { }

function is_prime(p)
  if p<=MAXP then return isprime(p, prime_table) end
  if math.mod(p, 2)==0 then return false end
  for i = 3, math.sqrt(p),2 do
    if math.mod(p, i)==0 then
      return false
    end
  end
  return true
end

function check_pandigital(length, prefix, pl)
  if length==pl then
    p = tonumber(prefix)
    if p>maxpan and is_prime(p) then
      print(p)
      maxpan = p
    end
  else
    for i = 1, length do
      if used[i]==nil then
        used[i] = true
        check_pandigital(length, i .. prefix, pl + 1)
        used[i] = nil
      end
    end
  end
end

for n = 1, 9 do
  check_pandigital(n, "", 0)
end
