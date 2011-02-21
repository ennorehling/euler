-- The n^(th) term of the sequence of triangle numbers is given by, t_(n) = ½n(n+1); so the first ten triangle numbers are:
-- 
-- 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
-- 
-- By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t_(10). If the word value is a triangle number then we shall call the word a triangle word.
-- 
-- Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?

-- euler 22
function wordscore(line)
  local s, i = 0
  for i = 1,string.len(line) do
    s = s + string.byte(line,i)-64
  end
  return s
end

file = io.open("words.txt", "r")
local scores = {}
local c = 1
while true do
  local line = file:read("*line")
  if line==nil then break end
  score = wordscore(line)
  local k = scores[score]
  if k==nil then
    scores[score] = 1
  else
    scores[score] = k + 1
  end
end

local total = 0
local t, i = 1, 2
for score in scores do
  while score>t do
    t = t + i
    i = i + 1
  end
  if score==t then
    total = total + scores[score]
  end
end
print(total)
