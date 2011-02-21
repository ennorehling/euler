function fact (n)
  if n == 0 then
    return 1
  else
    return n * fact(n-1)
  end
end

function T(d, n)
  local prod = 1
  local k 
  for k = 0, d-1 do
    prod = prod * (n+k)
  end
  return prod / fact(d)
end

function p(n)
  local sum, i = 0
  for i = 0, n do
    sum = sum + T(i, n)
  end
  return sum
end

print(p(20))

