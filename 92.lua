function addsquares(n)
	local s = 0
	while n>0 do
		local d = n % 10
		s = s + d * d
		n = math.floor(n / 10)
	end
	return s
end

function slow(limit)
	local ends = {}
	local result = 0
	for i = 1, limit-1 do
		n = i
		while n ~= 1 and n ~= 89 do
			n = addsquares(n)
			if n<i then
				n = ends[n]
			end
		end
		if n == 89 then
			result = result + 1
		elseif i % 100 == 0 then
			print(i)
		end
		ends[i] = n
	end
	return result
end

print slow(10000000)
