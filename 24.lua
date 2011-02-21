-- A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
--
-- 012   021   102   120   201   210
--
-- What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

prod = { 1 }

local i
for i = 2, 10 do prod[i] = prod[i-1] * i end

function p(i, keys)
  for k, v in pairs(keys) do
    if i==1 then return k end
    i = i-1
  end
  assert(false)
end

function get(i, n, keys)
  if i==1 then return p(1, keys) end
  local k, r = math.floor(n/prod[i-1]), math.mod(n, prod[i-1])
  return p(k+1, keys), r
end

function permutation(i, keys)
  local m = ""
  local k
  local n = i - 1
  for k=10,1,-1 do
    x, n = get(k, n, keys)
    m = m .. keys[x]
    keys[x] = nil
  end
  return m
end

local test = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
print(permutation(1000000, test))
