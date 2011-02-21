function add(a, b)
  local c = ""
  local al = a:len()
  local bl = b:len()
  local carry = 0
  while al>=1 or bl>=1 do
    if al>=1 then
      carry = carry + string.byte(a, al)-48
      al = al-1
    end
    if bl>=1 then
      carry = carry + string.byte(b, bl)-48
      bl = bl-1
    end
    local n = math.mod(carry, 10)
    carry = (carry-n)/10
    c = string.char(n+48) .. c
  end
  if carry>0 then
    c = string.char(carry+48) .. c
  end
  return c
end

function mul(a, b)
  local alen = a:len()
  local blen = b:len()
  if alen<=7 then
    if blen<=7 then
      return tostring(tonumber(a)*tonumber(b))
    else
      local bh = string.sub(b, 1, blen-7)
      local bl = string.sub(b, blen-6)
      local x = mul(a, bl)
      local y = mul(a, bh)
      return add(x, y .. "0000000")
    end
  else
    local ah = string.sub(a, 1, alen-7)
    local al = string.sub(a, alen-6)
    local x = mul(al, b)
    local y = mul(ah, b)
    return add(x, y .. "0000000")
  end
  return "0"
end

local c, i = "1"
for i = 1, 100 do
  c = mul(c, tostring(i))
end
print(c)
local sum = 0
for i = 1, c:len() do
  sum = sum + (c:byte(i)-48)
end
print(sum)