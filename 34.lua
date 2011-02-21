local fn = { 1 }

function fact (n)
  if fn[n+1]~=nil then return fn[n+1] end
  local a = n * fact(n-1)
  fn[n+1] = a
  return a
end

local i
for i=3, 10000000 do
  local s = tostring(i)
  local k, sum, fac = 0, 0, 0
  for k = 1,string.len(s) do
    sum = sum + fact(string.byte(s, k)-48)
  end
  if (sum==i) then print(sum) end
end
