local SingleMotor = require(script.Parent.SingleMotor)
local GroupMotor = require(script.Parent.GroupMotor)

return {
	new = function(initialValue, useImplicitConnections)
		assert(initialValue, "Missing argument #1: initialValue")

		if type(initialValue) == "number" then
			return SingleMotor.new(initialValue, useImplicitConnections)
		else
			return GroupMotor.new(initialValue, useImplicitConnections)
		end
	end
}
