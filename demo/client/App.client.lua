local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local Flipper = require(ReplicatedStorage.Flipper)

local SPRING_OPTIONS = {
	frequency = 1,
	dampingRatio = 1
}

local Mover2D = Roact.Component:extend("Mover2D")

function Mover2D:init(props)
	local motor = Flipper.SingleMotor.new(props.InitialValue)
	local binding, bindingUpdate = Roact.createBinding(motor:getValue())
	motor:onStep(bindingUpdate)

	self.motor = motor
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

local Mover3D = Roact.Component:extend("Mover3D")

function Mover3D:init(props)
	local motor = Flipper.SingleMotor.new(Vector3.new())
	local binding, bindingUpdate = Roact.createBinding(motor:getValue())
	motor:onStep(bindingUpdate)

	self.motor = motor
	self.binding = binding

	local thread = coroutine.create(function()
		while wait(2) do
			motor:setGoal(props.GoalSetter())
		end
	end)
	coroutine.resume(thread)
end

function Mover3D:render()
	print("yo")
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

local App2D = Roact.createElement("ScreenGui", {}, {
	NumberSpring = Roact.createElement(Mover2D, {
		InitialValue = 0,
		GoalSetter = function()
			return Flipper.Spring.new(math.random(), SPRING_OPTIONS)
		end,
		GoalSetterType = "Number Spring"
	}),
	Vector2Spring = Roact.createElement(Mover2D, {
		InitialValue = Vector2.new(),
		GoalSetter = function()
			return Flipper.Spring.new(
				Vector2.new(math.random(), math.random()),
				SPRING_OPTIONS
			)
		end,
		GoalSetterType = "Vector2 Spring"
	}),
	NumberLinear = Roact.createElement(Mover2D, {
		InitialValue = 0,
		GoalSetter = function()
			return Flipper.Linear.new(math.random(), {velocity = 1})
		end,
		GoalSetterType = "Number Linear"
	}),
	Vector2Linear = Roact.createElement(Mover2D, {
		InitialValue = Vector2.new(),
		GoalSetter = function()
			return Flipper.Linear.new(
				Vector2.new(math.random(), math.random()),
				{
					velocity = 1
				}
			)
		end,
		GoalSetterType = "Vector2 Linear"
	})
})

local App3D = Roact.createFragment({
	["Vector3 Linear"] = Roact.createElement(Mover3D, {
		GoalSetter = function()
			return Flipper.Linear.new(
				Vector3.new(math.random(), math.random(), math.random()) * 10,
				{
					velocity = 10
				}
			)
		end,
		GoalSetterType = "Vector3 Linear"
	}),
	["Vector3 Spring"] = Roact.createElement(Mover3D, {
		GoalSetter = function()
			return Flipper.Spring.new(
				Vector3.new(math.random(), math.random(), math.random()) * 10,
				SPRING_OPTIONS
			)
		end
	})
})

Roact.mount(App2D, Players.LocalPlayer:WaitForChild("PlayerGui"), "App")
Roact.mount(App3D, workspace)