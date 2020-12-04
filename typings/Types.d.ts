type Types =
	  Color3
	| Vector2
	| Vector3
	| UDim
	| NumberRange
	| Vector3int16
	| Vector2int16
	| Rect
	| Region3int16
	| UDim2
	| number
	| Types[]
	| {
		[name: string]: Types
	}


export = Types
