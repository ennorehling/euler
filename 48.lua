require("BigNum")
sum = BigNum.new()
a = BigNum.new()
for i=1,1000 do
  BigNum.change(a, i)
  BigNum.add(sum, BigNum.pow(a, a), sum)
end
print(sum)
