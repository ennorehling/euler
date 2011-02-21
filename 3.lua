local n = 600851475143 
local p = 2
while p<n do
  if math.mod(n/p,1)==0 then
    n = n/p
    print(p)
    p = 1
  end
  p = p+1
end
print(n)
