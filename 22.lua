-- euler 22
file = io.open("sorted.txt", "r")
local score = 0
local c = 1
while true do
  local line = file:read("*line")
  if line==nil then break end
  local s, i = 0
  for i = 1,string.len(line) do
    s = s + string.byte(line,i)-64
  end
  score = score + s * c
  c = c + 1
  print(score)
  -- break
end
print(score)
