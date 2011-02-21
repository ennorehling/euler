-- result: 31626
-- time:

-- Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
-- If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
-- 
-- For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
-- 
-- Evaluate the sum of all the amicable numbers under 10000.

require "euler"

local MAX = 10000
primes, prime_table = sieve_primes(MAX)

function sum(t, b, e)
  local s = 1
  local i
  for i = b, e do
    local p = primes[i]
    local x = t[i]
    local m = 1
    for k = 1, x do
      m = m + math.pow(p, k)
    end
    s = s * m
    -- print("-", s, x, p)
  end
  return s
end

function test(n)
  local x, l = prime_divisors(n, primes)
  local k, v
  -- for k, v in ipairs(x) do print(v, primes[k]) end
  k = sum(x, 1, l) - n
  -- print(n, k)
  return k
end

assert(test(4*9)==91-4*9)
assert(test(6)==1+2+3)
assert(test(12)==1+2+3+4+6)
assert(test(2)==1)
assert(test(4)==3)
assert(test(284)==220)
assert(test(220)==284)

-- exit()

print("go!")
local a = 2
local m = 0
while a<MAX do
  local b = test(a)
  if b<a and test(b)==a then
    -- print("=", b, a)
    m = m + a + b
  end
  a = a+1
end
print(m)
