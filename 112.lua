-- solved

function is_bouncy(n)
  local s = tostring(n)
  local sl = string.len(s)
  local i
  local dir = 0
  local p = string.byte(s, 1)
  for i = 2, sl do
    local p2 = string.byte(s, i)
    if p2>p then
      if dir<0 then return true end
      dir = 1
    elseif p2<p then
      if dir>0 then return true end
      dir = -1
    end
    p = p2
  end
  return false
end

assert(is_bouncy(1232))
assert(not is_bouncy(1233))

a=100
b=0

for i=101,10000000 do
  if not is_bouncy(i) then
    a = a + 1
  else
    b = b + 1
  end
  if (a/(a+b))<=0.01 then
    print(i, a, b, a/(a+b))
    break
  end
end
