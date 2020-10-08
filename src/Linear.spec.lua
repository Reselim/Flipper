return function()
	local SingleMotor = require(script.Parent.SingleMotor)
	local Linear = require(script.Parent.Linear)

	describe("completed state", function()
		local motor = SingleMotor.new(0)

		local goal = Linear.new(1, { velocity = 1 })
		motor:setGoal(goal)
	
		for _ = 1, 100 do
			motor:step(1/60)
		end
		
		it("should complete", function()
			expect(motor._state.complete).to.equal(true)
		end)

		it("should be exactly the goal value when completed", function()
			expect(motor._state.value).to.equal(1)
		end)
	end)
end