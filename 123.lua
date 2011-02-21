-- Let p_(n) be the nth prime: 2, 3, 5, 7, 11, ..., and let r be the remainder when (p_(n)−1)^(n) + (p_(n)+1)^(n) is divided by p_(n)^(2).
-- 
-- For example, when n = 3, p_(3) = 5, and 4^(3) + 6^(3) = 280 ≡ 5 mod 25.
-- 
-- The least value of n for which the remainder first exceeds 10^(9) is 7037.
-- 
-- Find the least value of n for which the remainder first exceeds 10^(10).

require "euler"
require "BigNum"

primes, prime_table = sieve_primes(1000000)

a = BigNum.new()
b = BigNum.new()
c = BigNum.new()
d = BigNum.new()
function calc(p, n)
  BigNum.change(a, p-1)
  BigNum.change(b, n)
  c = BigNum.pow(a, b)
  BigNum.change(a, p+1)
  d = BigNum.pow(a, b)
  BigNum.add(c, d, a)
  BigNum.change(c, p)
  BigNum.mul(c, c, b)
  BigNum.div( a , b , c , d )
  return tostring(d)
end

maxr = 0
for n, p in ipairs(primes) do
  local r = calc(p, n)
  if tonumber(r) > maxr then
    print(p, r)
    maxr = tonumber(r)
  end
end
