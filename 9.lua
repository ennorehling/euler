local a, b, c
for c = 3, 1000 do
  for b = 1, c-1 do
    a = 1000-b-c
    if a>0 and a<b and a*a+b*b==c*c then print(a, b, c, a*b*c) end
  end
end
