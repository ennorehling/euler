local i
local numbers = {}
local primes = { 2, 3, 5}
local primeprod = 30 -- 2*3*5
for i = 2,20 do
  local j = i*(2520/i-math.mod(2520/i,1))
  while (math.mod(j, primes)~=0) do
    j = j-i
  end
  numbers[i] = j
  
end

local mx = 2520
local i = 2
while i<21 do
  local j = numbers[i]
  local inc = i
  while j<mx do
    j = j + inc
  end
  numbers[i] = j
  if j==mx then
    i = i+1
  else
    mx = j
    i = 2
  end
end
print(mx)
