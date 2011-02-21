local i = 1
local j = 2
local k = 3
local sum = 2
while k<4000000 do
  if math.mod(k,2)==0 then
    print(k)
    sum = sum + k
  end
  i = j
  j = k
  k = i+j
end
print(sum)
