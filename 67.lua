-- result: 7273
-- By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
-- 
-- 3
-- 7 5
-- 2 4 6
-- 8 5 9 3
-- 
-- That is, 3 + 7 + 4 + 9 = 23.
-- 
-- Find the maximum total from top to bottom in triangle.txt (right click and 'Save Link/Target As...'), a 15K text file containing a triangle with one-hundred rows.

function justWords(str)
  local t = {}
  local function helper(word) table.insert(t, word) return "" end
  if not str:gsub("%w+", helper):find"%S" then return t end
end

local tri = {}
local tcost = {}
local maxd = 0

function max(x, y)
  if x>y then return x else return y end
end

function tallest(y, x)
  if y==maxd then
    return tri[y][x]
  else
    local tc = tcost[y]
    if tc == nil then
      tc = {}
      tcost[y] = tc
    end
    local tcc = tc[x]
    if tcc==nil then
      tcc = tri[y][x] + max(tallest(y+1, x), tallest(y+1, x+1))
      tc[x] = tcc
      -- print(x, y, tcc)
    end
    return tcc
  end
end

local line
local file=io.open("triangle67.txt", "r")
while true do
  line = file:read('*line')
  if line == nil then break end
  maxd = maxd + 1
  tri[maxd] = justWords(line)
end

print(tallest(1, 1))
