local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local Flipper = require(ReplicatedStorage.Flipper)

local Mover3D = Roact.Component:extend("Mover3D")

function Mover3D:init(props)
	local motor = Flipper.SingleMotor.new(Vector3.new())
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

function Mover3D:render()
	return Roact.createElement("Model", {}, {
		Humanoid = Roact.createElement("Humanoid"),
		Head = Roact.createElement("Part", {
			Size = Vector3.new(2, 2, 2),
			Anchored = true,
			CanCollide = false,
			Position = self.binding
		})
	})
end

return Mover3D