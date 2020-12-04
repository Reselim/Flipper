return function()
	local Ser = require(script.Parent.Serializer)

	it("should serialize each data type", function()
		local udim2 = Ser.serialize(UDim2.new())
		expect(udim2.X).to.be.a("userdata")
		expect(udim2.X.Scale).to.equal(0)
		expect(udim2.X.Offset).to.equal(0)
		expect(udim2.Y).to.be.a("userdata")
		expect(udim2.Y.Scale).to.equal(0)
		expect(udim2.Y.Offset).to.equal(0)

		local rect = Ser.serialize(Rect.new(Vector2.new(), Vector2.new()))
		expect(rect.Min).to.be.a("userdata")
		expect(rect.Min.X).to.equal(0)
		expect(rect.Min.Y).to.equal(0)
		expect(rect.Max).to.be.a("userdata")
		expect(rect.Max.X).to.equal(0)
		expect(rect.Max.Y).to.equal(0)

		local udim = Ser.serialize(UDim.new(0, 0))
		expect(udim.Scale).to.equal(0)
		expect(udim.Offset).to.equal(0)

		local color3 = Ser.serialize(Color3.new())
		expect(color3.R).to.equal(0)
		expect(color3.G).to.equal(0)
		expect(color3.B).to.equal(0)

		local vector2 = Ser.serialize(Vector2.new())
		expect(vector2.X).to.equal(0)
		expect(vector2.Y).to.equal(0)

		local vector3 = Ser.serialize(Vector3.new())
		expect(vector3.X).to.equal(0)
		expect(vector3.Y).to.equal(0)
		expect(vector3.Z).to.equal(0)
	end)

	it("should deserialize each data type", function()
		local udim2 = Ser.deserialize({
			X = {
				Scale = 0,
				Offset = 0
			},
			Y = {
				Scale = 0,
				Offset = 0
			}
		}, "UDim2")
		expect(udim2).to.equal(UDim2.new())

		local rect = Ser.deserialize({
			Min = {
				X = 0,
				Y = 0
			},
			Max = {
				X = 0,
				Y = 0
			}
		}, "Rect")
		expect(rect).to.equal(Rect.new(Vector2.new(), Vector2.new()))

		local udim = Ser.deserialize({
			Scale = 0,
			Offset = 0
		}, "UDim")
		expect(udim).to.equal(UDim.new(0, 0))

		local color3 = Ser.deserialize({
			R = 0,
			G = 0,
			B = 0
		}, "Color3")
		expect(color3).to.equal(Color3.new())

		local vector2 = Ser.deserialize({
			X = 0,
			Y = 0
		}, "Vector2")
		expect(vector2).to.equal(Vector2.new())

		local vector3 = Ser.deserialize({
			X = 0,
			Y = 0,
			Z = 0
		}, "Vector3")
		expect(vector3).to.equal(Vector3.new())
	end)
end
