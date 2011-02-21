local sum = 0
local n = 75000000
local c = 75000000/2-1
local limit = 1
while c <= n/2 do
  local cc = c*c-1
  local b = c-1
  local a = 1
  while (b>=a) do
    a = math.sqrt(cc-b*b)
    if (math.mod(a,1)==0 and a+b+c<=n) then
      sum=sum+1
      if c>limit then
        print(sum, c, a+b+c)
        limit=limit+limit
      end
      break
    end
    b = b-1
  end
  c = c +1
end
print(sum,c)
