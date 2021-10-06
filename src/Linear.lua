--[=[
	@interface LinearOptions
	@within Linear
	@field velocity number -- How fast the goal should move towards the target. Default: 1
]=]

--[=[
	@class Linear

	Represents a linear Goal. Moves towards the target at a specified velocity.
]=]
local Linear = {}
Linear.__index = Linear

--[=[
	Creates a new Linear.

	@param targetValue number
	@param options LinearOptions
	@return Linear
]=]
function Linear.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")
	
	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_velocity = options.velocity or 1,
	}, Linear)
end

--[=[
	Advances the specified MotorState by `deltaTime * velocity` and returns a new MotorState.
]=]
function Linear:step(state, dt)
	local position = state.value
	local velocity = self._velocity -- Linear motion ignores the state's velocity
	local goal = self._targetValue

	local dPos = dt * velocity

	local complete = dPos >= math.abs(goal - position)
	position = position + dPos * (goal > position and 1 or -1)
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