function lame(n)
  local i = 0
  local j = 0
  local sum = 0
  while i<=n or j<=n do
    if i<j then
      sum=sum+i
      i=i+3
    else
      if j<i then
        sum=sum+j
        j=j+5
      else
        sum=sum+j
        j=j+5
        i=i+3
       end
    end
  end
  return sum
end

function good(n)
  function gauss(n)
    return n*(n+1)/2
  end
  return gauss(math.floor(n/3)) * 3 + gauss(math.floor(n/5)) * 5 - gauss(math.floor(n/15)) * 15
end

print(lame(999))
print(good(999))

