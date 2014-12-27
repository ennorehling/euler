coins = {200, 100, 50, 20, 10, 5, 2, 1 }

results = {}

function memget(total, sm)
	if results[sm]~=nil then
		return results[sm][total]
	end
	return nil
end

function memset(total, sm, value)
	if results[sm]==nil then
		results[sm] = {}
	end
	results[sm][total] = value
end

function fast(total, sm)
	sm = sm or 8
	local sum = memget(total, sm)
	if sum==nil then
		sum = 0
		for i = 1, sm do
			local coin = coins[i]
			if coin == total then
				sum = sum + 1
			elseif coin < total then
				sum = sum + fast(total-coin, i)
			end
		end
		memset(total, sm, sum)
	end
	return sum
end

function slow(total, sm)
	local sum = 0
	sm = sm or 8
	for i = 1, sm do
		local coin = coins[i]
		if coin == total then
			sum = sum + 1
		elseif coin < total then
			sum = sum + slow(total-coin, i)
		end
	end
	return sum
end

-- print(slow(200))
print(fast(200))
-- print(slow(200))
