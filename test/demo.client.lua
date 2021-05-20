local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Flipper = require(ReplicatedStorage.Flipper)

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

local testSpringProps = {
	frequency = 3.5,
	dampingRatio = 0.5,
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Example"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.BackgroundColor3 = Color3.new(1, 1, 1)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.new(1, 0, 0)
frame.Size = UDim2.new(0, 40, 0, 40)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = screenGui

local motor = Flipper.SingleMotor.new(Vector2.new())

motor:onStep(function(values)
	frame.Position = UDim2.new(0, values.X, 0, values.Y)
end)

motor:onComplete(function()
	print("Motor completed")
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		motor:setGoal(Flipper.Spring.new(
			Vector2.new(input.Position.X, input.Position.Y),
			testSpringProps
		))
	end
end)