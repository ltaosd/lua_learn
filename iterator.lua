
-- ipairs
local t = {
	"1", "2", "3"
}
local function _ipairs(_t)
	local i = 0
	return function ()
		i = i + 1
		if i <= #_t then
			return i, _t[i]
		end
	end
end
for i,v in _ipairs(t) do
	print(i,v)
end
for i,v in ipairs(t) do
	print(i,v)
end

local t1 = {
	x = 1,
	y = 2,
	z = 3,
}


function _pairs( t )
	return next, t
end
for k,v in _pairs(t1) do
	print(k,v)
end

for k,v in pairs(t1) do
	print(k,v)
end