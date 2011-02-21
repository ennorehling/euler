local length = {}

function len(a)
  if a==1 then return 1 end
  if length[a]==nil then
    if math.mod(a,2)==0 then
      length[a] = 1 + len(a/2)
    else
      length[a] = 1 + len(3*a+1)
    end
  end
  return length[a]
end

local i
local mx, ml = 0, 0
for i = 1,1000000 do
  local a = len(i)
  if a > ml then
    mx = i
    ml = a
  end
end
print(ml, mx)

