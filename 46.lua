-- not solved
prime = {}
composites = { }
maxc = 0

function sieve(mx)
  local i
  for i = 3,mx,2 do
    local k = prime[(i-1)/2]
    if k==nil then
      local x
      for x = i*3,mx,i*2 do
        prime[(x-1)/2] = false
      end
    else
      maxc = maxc + 1
      composites[maxc] = i
    end
  end
end

function isprime(p)
  if p==2 then
    return true
  end
  if math.mod(p,2)==0 then
    return false
  end
  return composites[(p-1)/2]==nil
end

m=0
sieve(100000)
for k, p in ipairs(composites) do
  print(p)
end
