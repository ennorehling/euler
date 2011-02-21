-- result: 16695334890
-- time: 0.1s
--
-- The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
-- 
-- Let d_(1) be the 1^(st) digit, d_(2) be the 2^(nd) digit, and so on. In this way, we note the following:
-- 
--     * d_(2)d_(3)d_(4)=406 is divisible by 2
--     * d_(3)d_(4)d_(5)=063 is divisible by 3
--     * d_(4)d_(5)d_(6)=635 is divisible by 5
--     * d_(5)d_(6)d_(7)=357 is divisible by 7
--     * d_(6)d_(7)d_(8)=572 is divisible by 11
--     * d_(7)d_(8)d_(9)=728 is divisible by 13
--     * d_(8)d_(9)d_(10)=289 is divisible by 17
-- 
-- Find the sum of all 0 to 9 pandigital numbers with this property.

primes = { 2, 3, 5, 7, 11, 13, 17 }
used = { }
total = 0

function locate(i, e, postfix)
  local p = primes[i]
  local k
  for k=p,999,p do
    if e==0 or math.mod(k, 100)==e then
      local a = math.mod(k, 10)
      local b = math.mod(k-a, 100)/10
      local c = (k-a-b*10)/100
      if a~=b and b~=c and c~=a and used[c+1]==nil then
        local pf
        if e==0 then
          used[a+1] = true
          used[b+1] = true
          pf = string.char(48+c, 48+b, 48+a)
        else
          pf = string.char(48+c) .. postfix
        end
        used[c+1] = true
        -- print(k)
        if i>1 then
          locate(i-1, c*10+b, pf)
        else
          local n,v,num
          for n,v in ipairs(used) do
            num = n .. pf
          end
          total = total + tonumber(num)
          -- print(k, num)
        end
        if e==0 then
          used[a+1] = nil
          used[b+1] = nil
        end
        used[c+1] = nil
      end
    end
  end
end

locate(7, 0, "")
print(total)
