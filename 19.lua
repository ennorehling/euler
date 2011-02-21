require "date"

d = date(1901, 1, 1)
m = 0
d.day = 1
for year = 1901, 2000 do
  for month = 1, 12 do
    if d:getweekday()==1 then
      print(d)
      m = m + 1
    end
    d:addmonths(1)
  end
end
print(m)
