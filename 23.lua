-- A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
--
-- A number whose proper divisors are less than the number is called deficient and a number whose proper divisors exceed the number is called abundant.
--
-- As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.
--
-- Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

require "euler"

local last = 28123
primes, prime_table = sieve_primes(last)

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
  end
  return s
end

abundance = {}

function is_abundant(i)
  local x = abundance[i]
  if x==nil then 
    local d, n = prime_divisors(i, primes)
    x = sum(d, 1, n) - i
    abundance[i] = x
  end
  -- print(i, x)
  return x>i
end

function is_perfect(i)
  local x = abundance[i]
  if x==nil then 
    local d, n = prime_divisors(i, primes)
    x = sum(d, 1, n) - i
    abundance[i] = x
  end
  -- print(i, x)
  return x==i
end

function test(n)
  local x, l = prime_divisors(n, primes)
  local k, v
  for k, v in pairs(x) do print(v, primes[k]) end
  k = sum(x, 1, l) - n
  return k
end

-- print(test(284))
assert(test(284)==220)
assert(test(4*9)==91-4*9)
assert(test(6)==1+2+3)
assert(test(12)==1+2+3+4+6)
assert(test(2)==1)
assert(test(4)==3)
assert(test(220)==284)

assert(is_perfect(28))
assert(is_abundant(12))
assert(not is_abundant(28))

local i
local a, abundant = 0, {}
for i=12,last do
  if is_abundant(i) then
    a = a + 1
    abundant[a] = i
  end
end

-- for k, v in ipairs(abundant) do print(v) end

local sum = 0
for i=1,last do
  local k, v
  local found = false
  for k, v in ipairs(abundant) do
    local r = i-v
    if r<v then break end
    if is_abundant(r) then 
      found = true
      break
    end
  end
  if not found then
    sum = sum + i
  end
end
print(sum)
