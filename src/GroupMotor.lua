local BaseMotor = require(script.Parent.BaseMotor)
local SingleMotor = require(script.Parent.SingleMotor)

local isMotor = require(script.Parent.isMotor)

--[=[
	@interface GroupMotorValues
	@within GroupMotor
	@field [string] number | GroupMotorValues
]=]

--[=[
	@interface GroupMotorGoals
	@within GroupMotor
	@field [string] Goal | GroupMotorGoals
]=]

--[=[
	Motor representing a group of values.

	Internally, this manages a bunch of "sub-motors" — allowing for nested values.
	
	See also: [BaseMotor](BaseMotor)

	@class GroupMotor
]=]
local GroupMotor = setmetatable({}, BaseMotor)
GroupMotor.__index = GroupMotor

--[[
	Turns a value into a motor, with `useImplicitConnections` set to false.

	- If it's a motor, it returns the value as-is
	- If `number`, returns a SingleMotor
	- If `table`, returns a GroupMotor

	@param value number | GroupMotorValues
	@return SingleMotor | GroupMotor
]]
local function toMotor(value)
	if isMotor(value) then
		return value
	end

	local valueType = typeof(value)

	if valueType == "number" then
		return SingleMotor.new(value, false)
	elseif valueType == "table" then
		return GroupMotor.new(value, false)
	end

	error(("Unable to convert %q to motor; type %s is unsupported"):format(value, valueType), 2)
end

--[=[
	Creates a new GroupMotor.

	@param initialValues GroupMotorValues
	@param useImplicitConnections boolean -- Should connections to RunService be automatically managed?
	@return GroupMotor
]=]
function GroupMotor.new(initialValues, useImplicitConnections)
	assert(initialValues, "Missing argument #1: initialValues")
	assert(typeof(initialValues) == "table", "initialValues must be a table!")
	assert(not initialValues.step, "initialValues contains disallowed property \"step\". Did you mean to put a table of values here?")

	local self = setmetatable(BaseMotor.new(), GroupMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._complete = true
	self._motors = {}

	for key, value in pairs(initialValues) do
		self._motors[key] = toMotor(value)
	end

	return self
end

--[=[
	Advances all sub-motors by a given time.

	@param deltaTime number
	@return boolean -- Are all sub-motors complete?
]=]
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

--[=[
	Sets sub-motor goals and hooks up a new connection if useImplicitConnections is enabled.

	@param goals GroupMotorGoals
	@return nil
]=]
function GroupMotor:setGoal(goals)
	assert(not goals.step, "goals contains disallowed property \"step\". Did you mean to put a table of goals here?")

	self._complete = false
	self._onStart:fire()

	for key, goal in pairs(goals) do
		local motor = assert(self._motors[key], ("Unknown motor for key %s"):format(key))
		motor:setGoal(goal)
	end

	if self._useImplicitConnections then
		self:start()
	end
end

--[=[
	Returns the current values of the GroupMotor.

	@return GroupMotorValues
]=]
function GroupMotor:getValue()
	local values = {}

	for key, motor in pairs(self._motors) do
		values[key] = motor:getValue()
	end

	return values
end

--[=[
	Returns the type of motor. Used for isMotor.

	@return string
]=]
function GroupMotor:__tostring()
	return "Motor(Group)"
end

return GroupMotor
