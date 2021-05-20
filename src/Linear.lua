local Types = require(script.Parent.Types)
local TYPE_MISMATCH_ERROR = "Type mistmatch between initialValue (%s) and targetValue(%s)"

local Linear = {}
Linear.__index = Linear

function Linear.new(targetValue: Types.MotorValue, options: Types.LinearOptions?)
	assert(targetValue, "Missing argument #1: targetValue")
	
	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_velocity = options.velocity or 1,
	}, Linear)
end

function Linear:step(state, dt)
	local position = state.value
	local velocity = self._velocity -- Linear motion ignores the state's velocity
	local goal = self._targetValue

	local positionType = typeof(position)
	local goalType = typeof(goal)
	assert(positionType == goalType, TYPE_MISMATCH_ERROR:format(positionType, goalType))

	local dPos, complete
	if positionType == "number" then
		dPos = dt * velocity
		complete = dPos >= math.abs(goal - position)
		position = position + dPos * (goal > position and 1 or -1)
	else
		local posToGoal = goal - position
		dPos = posToGoal.Unit * dt * velocity
		complete = dPos.Magnitude >= posToGoal.Magnitude
		position = position + dPos
	end

	if complete then
		position = self._targetValue
		velocity = 0
	end
	
	return {
		complete = complete,
		value = position,
		velocity = velocity,
	}
end

return Linear