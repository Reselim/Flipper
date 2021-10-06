--[=[
	@class Instant

	Represents an Instant goal. Always returns a complete state with the provided value.
]=]
local Instant = {}
Instant.__index = Instant

--[=[
	Creates a new Instant.

	@param targetValue number
	@return Instant
]=]
function Instant.new(targetValue)
	return setmetatable({
		_targetValue = targetValue,
	}, Instant)
end

--[=[
	Returns a complete MotorState with `value` set to `targetValue`.
]=]
function Instant:step()
	return {
		complete = true,
		value = self._targetValue,
	}
end

return Instant