function slow(limit)
	local results = {}
	local n = 0
	for a = 2, limit do
		for b = 2, limit do
			x = math.pow(a, b)
			if results[x]==nil then
				results[x] = true
				n = n + 1
			end
		end
	end
	return n
end

print(slow(100))
