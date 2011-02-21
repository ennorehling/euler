-- result: 249
-- time: 1.4s
--
-- If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.
-- 
-- Not all numbers produce palindromes so quickly. For example,
-- 
-- 349 + 943 = 1292,
-- 1292 + 2921 = 4213
-- 4213 + 3124 = 7337
-- 
-- That is, 349 took three iterations to arrive at a palindrome.
-- 
-- Although no one has proved it yet, it is thought that some numbers, like 196, never produce a palindrome. A number that never forms a palindrome through the reverse and add process is called a Lychrel number. Due to the theoretical nature of these numbers, and for the purpose of this problem, we shall assume that a number is Lychrel until proven otherwise. In addition you are given that for every number below ten-thousand, it will either (i) become a palindrome in less than fifty iterations, or, (ii) no one, with all the computing power that exists, has managed so far to map it to a palindrome. In fact, 10677 is the first number to be shown to require over fifty iterations before producing a palindrome: 4668731596684224866951378664 (53 iterations, 28-digits).
-- 
-- Surprisingly, there are palindromic numbers that are themselves Lychrel numbers; the first example is 4994.
-- 
-- How many Lychrel numbers are there below ten-thousand?

require "BigNum"

function palindrome_s(s)
  local sl = string.len(s)
  local i
  for i=1,sl/2 do
    if string.byte(s, i)~=string.byte(s,sl+1-i) then
      return false
    end
  end
  return true
end

function reverse_b(b, d)
  local s = string.reverse(tostring(b))
  BigNum.change(d, s)
end

assert(palindrome_s("12321"))
assert(not palindrome_s("124321"))
assert(palindrome_s("123321"))

local i, ib, ir
ib = BigNum.new()
ir = BigNum.new()

function lychrel(i)
  local iter = 1
  BigNum.change(ib, i)
  while iter<=100 do
    -- print(ib, string.reverse(tostring(ib)))
    iter = iter + 1
    reverse_b(ib, ir)
    BigNum.add(ib, ir, ib)
    if palindrome_s(tostring(ib)) then
      return false
    end
  end
  return true
end

assert(not lychrel(349))
assert(lychrel(196))

local num = 0
for i = 1,9999 do
  if lychrel(i) then
    -- print(i)
    num = num + 1
  end
end
print(num)
