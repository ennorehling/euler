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

function digits(a)
  local sum = 0
  for i=1,a:len() do
    sum = sum+a:byte(i)-48
  end
  return sum
end

a = "2"
for p=2,1000 do
  a = add(a,a)
end
print(digits(a))
