-- result: 443839
function pw(s, n)
  local sl, k, b, j
  k = 0
  sl = string.len(s)
  for j = 1, sl do
    b = string.byte(s, j)-48
    k = k + math.pow(b, n)
  end
  return k
end

n = 5
m = 0
i = 2
while i < 1000000 do
  s = tostring(i)
  k = pw(s, n)
  if k == i then
    print(k)
    m = m + k
  end
  i = i + 1
end
print("")
print(m)
