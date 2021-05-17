local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local Flipper = require(ReplicatedStorage.Flipper)

local Mover2D = Roact.Component:extend("Mover2D")

function Mover2D:init(props)
	local motor = Flipper.SingleMotor.new(props.InitialValue)
	local binding, bindingUpdate = Roact.createBinding(motor:getValue())
	motor:onStep(bindingUpdate)

	self.binding = binding

	local thread = coroutine.create(function()
		while wait(2) do
			motor:setGoal(props.GoalSetter())
		end
	end)
	coroutine.resume(thread)
end

function Mover2D:render()
	return Roact.createElement("TextLabel", {
		Size = UDim2.fromOffset(100, 100),
		Position = self.binding:map(function(value)
			if typeof(value) == "number" then
				return UDim2.fromScale(value, 0)
			else
				return UDim2.fromScale(value.X, value.Y)
			end
		end),
		Text = self.props.GoalSetterType
	})
end

return Mover2D