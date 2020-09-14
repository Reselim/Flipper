interface InstantState {
	value: number,
	complete: boolean
}

declare interface Instant {
	step(state: InstantState, deltaTime: number): InstantState
}

declare interface InstantConstructor {
	new(targetValue: number): Instant
}

declare const Instant: InstantConstructor
export = Instant