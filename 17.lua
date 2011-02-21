small = { "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" }
tens = { "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" }
hundred = "hundred"

function len(a)
  local l = 0
  if a<20 then
    l = small[a]:len() -- eleven
  elseif a >= 100 then
    local b = math.floor(a/100)
    local t = math.mod(a,100)
    l = len(b) + hundred:len() -- one hundred
    if t>0 then
      l = l + len(t) + 3 -- and ...
    end
  else
    local t = math.mod(a,10)
    local b = math.floor(a/10)
    l = tens[b]:len() -- twenty ...
    if t>0 then
      l = l + len(t) -- five
    end
  end
  return l
end

local i
local sum = 11
for i = 1, 999 do
  sum = sum + len(i)
 end
 print(sum)
 print(len(342), len(115))
 