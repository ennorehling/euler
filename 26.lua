-- result: 983

m = 0
for d = 1,1000 do
  b = { }
  n = 1
  p = 0
  while n~=0 do
    while n<d do
      p = p + 1
      n = n * 10
    end
    n = math.mod(n, d)
    if b[n]~=nil then
      if p-b[n]>m then
        m = p-b[n]
      end
      break
    else
      b[n] = p
    end
  end
end
print(m)
