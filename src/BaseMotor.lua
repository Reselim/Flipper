local RunService = game:GetService("RunService")

local Signal = require(script.Parent.Signal)

local noop = function() end

--[=[
	@interface MotorState
	@within BaseMotor
	@field value number
	@field velocity number
	@field complete boolean
]=]

--[=[
	@class BaseMotor

	Base class for SingleMotor and GroupMotor, manages connections to RunService.
]=]
local BaseMotor = {}
BaseMotor.__index = BaseMotor

function BaseMotor.new()
	return setmetatable({
		_onStep = Signal.new(),
		_onStart = Signal.new(),
		_onComplete = Signal.new(),
	}, BaseMotor)
end

--[=[
	Fired when the motor's state updates.

	@param handler (state: unknown) -> nil
	@return Connection
]=]
function BaseMotor:onStep(handler)
	return self._onStep:connect(handler)
end

--[=[
	Fired whenever BaseMotor:start() is called.

	If `useImplicitConnections` is set to true, this will be called whenever setGoal is called.

	@param handler () -> nil
	@return Connection
]=]
function BaseMotor:onStart(handler)
	return self._onStart:connect(handler)
end

--[=[
	Fired whenever a motor finishes.

	It's recommended to use onStep and check for a certain threshold (i.e. 99% of the way there) instead of using this, as it can often take a while to fire.

	@param handler () -> nil
	@return Connection
]=]
function BaseMotor:onComplete(handler)
	return self._onComplete:connect(handler)
end

--[=[
	Creates a connection to RunService if there isn't one already.

	@return nil
]=]
function BaseMotor:start()
	if not self._connection then
		self._connection = RunService.RenderStepped:Connect(function(deltaTime)
			self:step(deltaTime)
		end)
	end
end

--[=[
	Removes the connection to RunService if it exists.

	@return nil
]=]
function BaseMotor:stop()
	if self._connection then
		self._connection:Disconnect()
		self._connection = nil
	end
end

BaseMotor.destroy = BaseMotor.stop

BaseMotor.step = noop
BaseMotor.getValue = noop
BaseMotor.setGoal = noop

--[=[
	Returns the type of motor. Used for isMotor.

	@return string
]=]
function BaseMotor:__tostring()
	return "Motor"
end

return BaseMotor
