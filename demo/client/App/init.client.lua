local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local Flipper = require(ReplicatedStorage.Flipper)

local Mover2D = require(script.Mover2D)
local Mover3D = require(script.Mover3D)

local SPRING_OPTIONS = {
	frequency = 1,
	dampingRatio = 1
}

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