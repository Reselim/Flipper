local types = {
	Color3 = {"R", "G", "B"},
	Vector2 = {"X", "Y"},
	Vector3 = {"X", "Y", "Z"},
	UDim = {"Scale", "Offset"},
	NumberRange = {"Min", "Max"},
}

types.Vector3int16 = types.Vector3
types.Vector2int16 = types.Vector2

types.Rect = {
	"Min", types.Vector2,
	"Max", types.Vector2
}
types.Region3int16 = {
	"Min", types.Vector3int16,
	"Max", types.Vector3int16
}
types.UDim2 = {
	"X", types.UDim,
	"Y", types.UDim,
}


for dataType, props in pairs(types) do
	props.t = dataType -- used for deserializing nested data types
end


local function serialize(data)
	local dataType = typeof(data)
	local order = types[dataType]
	local ser = {}
	for index, property in ipairs(order) do
		if type(property) == "table" then
			local last = order[index - 1]
			ser[last] = data[last]
		else
			ser[property] = data[property]
		end
	end

	return ser
end


local env = getfenv()
local function deserialize(data, dataType)
	local order = types[dataType]

	local last = 0
	local ser = {}
	for index, property in ipairs(order) do
		if type(property) == "table" then
			ser[last] = deserialize(data[order[index - 1]], property.t)
		else -- check for the next rather than last for a slight optimization :)
			table.insert(ser, data[property])
			last += 1
		end
	end

	return env[dataType].new(unpack(ser))
end


local function has(dataType)
	return types[dataType] and true or false
end


return {
	types = types,

	has = has,
	serialize = serialize,
	deserialize = deserialize
}
