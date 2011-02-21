local mx = 0
local a, b, c
for a = 9,0,-1 do
  for b = 9,0,-1 do
    for c = 9,0,-1 do
      local p = a*100001+b*10010+c*1100
      local n
      for n = 999,1,-1 do
        local k = p/n
        if (k<1000 and math.mod(k,1)==0) then
          mx = 1
          print(k, n, p)
        end
        if mx>0 then break end
      end
      if mx>0 then break end
    end
    if mx>0 then break end
  end
  if mx>0 then break end
end
