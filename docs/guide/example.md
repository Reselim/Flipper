# Usage

## With Roact

This example creates a button that shrinks when pressed.

```lua
local Example = Roact.Component:extend("Example")

function Example:init()
	self.motor = Flipper.SingleMotor.new(0)

	local binding, setBinding = Roact.createBinding(self.motor:getValue())
	self.binding = binding

	self.motor:onStep(setBinding)
end

function Example:render()
	return Roact.createElement("ImageButton", {
		Size = self.binding:map(function(value)
			return UDim2.new(0, 100, 0, 100):Lerp(UDim2.new(0, 80, 0, 80), value)
		end),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[Roact.Event.MouseButton1Down] = function()
			self.motor:setGoal(Flipper.Spring.new(1, {
				frequency = 5,
				dampingRatio = 1
			}))
		end,

		[Roact.Event.MouseButton1Up] = function()
			self.motor:setGoal(Flipper.Spring.new(0, {
				frequency = 4,
				dampingRatio = 0.75
			}))
		end
	})
end

return Example
```

Flipper works wonderfully with Roact on its own, but if you plan on using it for a lot of your components, [roact-flipper](https://github.com/Reselim/roact-flipper) will make that *much* easier.

## Without Roact

Check out the [demo script](https://github.com/Reselim/Flipper/blob/master/test/demo.client.lua) in the test project!