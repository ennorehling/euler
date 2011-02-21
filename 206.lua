require("BigNum")

function bigsearch(mn, mx)
  local i = mn
  local sq = BigNum.new( )
  local ctr = 0

  local x = BigNum.new( )
  while i~=mx do
    BigNum.change(x, i)
    BigNum.mul(x, x, sq)
    if string.find(tostring(sq), "1.2.3.4.5.6.7.8.9.0")~=nil then
      print(sq, i)
    end
    ctr=ctr+1
    if ctr==10000 then
      -- print(i)
      ctr=0
    end
    i = i+100
  end
  print(sq)
end

function fast(l1, l2)
  local found = {}
  local maxf = 0
  for i=1,100000 do
    a = i * i
    local s = tostring(a)
    x, y = string.find(s, "8.9.0")
    if y == string.len(s) then
      maxf = maxf + 1
      found[maxf] = i
--      print(i)
    end
  end
  print (maxf)
  local maxl = string.len(tostring(l1))
  for k=1,maxf do 
    local tail = tostring(found[k])
    local tlen = string.len(tail)
    local mn = tonumber(string.sub(tostring(l1), 1, maxl-tlen))-1
    local mx = tonumber(string.sub(tostring(l2), 1, maxl-tlen))+1
    -- print(mn, mx, tail)
    local sq = BigNum.new()
    local i = mn
    local c = BigNum.new()
    while i~=mx do
      BigNum.change(c, tostring(i) .. tail)
      BigNum.mul(c, c, sq)
      if string.find(tostring(sq), "1.2.3.4.5.6.7.8.9.0")~=nil then
        print(sq, i, tail)
      end
      i = i+1
    end
--    print(sq)
  end
end

local mn = 1010101030
local mx = 1414213630
fast(mn, mx)
