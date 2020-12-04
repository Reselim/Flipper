local BaseMotor = require(script.Parent.BaseMotor)
local SingleMotor = require(script.Parent.SingleMotor)

local isMotor = require(script.Parent.isMotor)
local Ser = require(script.Parent.Serializer)

local GroupMotor = setmetatable({}, BaseMotor)
GroupMotor.__index = GroupMotor

local function serializeGoal(goalClass, goal)
	local data = Ser.serialize(goal._targetValue)
	for property, value in pairs(data) do
		data[property] = goalClass.new(value, goal._options)
	end

	return data
end

local function toMotor(value)
	if isMotor(value) then
		return value
	end

	local valueType = typeof(value)

	if valueType == "number" then
		return SingleMotor.new(value, false)
	elseif valueType == "table" then
		return GroupMotor.new(value, false, true)
	elseif Ser.has(valueType) then
		return GroupMotor.new(
			Ser.serialize(value),
			false,
			true,
			valueType
		)
	end

	error(("Unable to convert %q to motor; type %s is unsupported"):format(value, valueType), 2)
end

function GroupMotor.new(initialValues, useImplicitConnections, notTopSuper, dataType)
	local valueType = typeof(initialValues)
	if Ser.has(valueType) then
		return GroupMotor.new(
			Ser.serialize(initialValues),
			nil,
			nil,
			valueType
		)
	end

	assert(valueType == "table", "initialValues must be a table or data type!")

	local self = setmetatable(BaseMotor.new(), GroupMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._isTopSuper = not notTopSuper
	self._dataType = dataType
	self._complete = true
	self._motors = {}

	for key, value in pairs(initialValues) do
		self._motors[key] = toMotor(value)
	end

	return self
end

function GroupMotor:step(deltaTime)
	if self._complete then
		return true
	end

	local allMotorsComplete = true

	for _, motor in pairs(self._motors) do
		local complete = motor:step(deltaTime)
		if not complete then
			-- If any of the sub-motors are incomplete, the group motor will not be complete either
			allMotorsComplete = false
		end
	end

	self._onStep:fire(self:getValue())

	if allMotorsComplete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._complete = true
		self._onComplete:fire()
	end

	return allMotorsComplete
end

function GroupMotor:setGoal(goals)
	self._complete = false

	if self._isTopSuper then -- if the goal is a direct data type
		local isGoal = getmetatable(goals)
		if isGoal then
			goals = serializeGoal(isGoal, goals)
		end
	end

	for key, goal in pairs(goals) do
		local motor = assert(self._motors[key], ("Unknown motor for key %s"):format(key))
		if motor._dataType then
			local goalClass = getmetatable(goal)
			motor:setGoal(serializeGoal(goalClass, goal))
		else
			motor:setGoal(goal)
		end
	end

	if self._useImplicitConnections then
		self:start()
	end
end

function GroupMotor:getValue(noDeserializing) -- param for nested data types
	local values = {}

	for key, motor in pairs(self._motors) do
		values[key] = motor:getValue(self._dataType and true)
	end

	if not noDeserializing and self._dataType then
		return Ser.deserialize(values, self._dataType)
	else
		return values
	end
end

function GroupMotor:__tostring()
	return "Motor(Group)"
end

return GroupMotor
