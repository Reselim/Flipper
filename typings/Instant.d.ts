interface InstantState {
	value: number,
	complete: boolean
}

export default class Instant {
	/**
	 * Creates a new Instant goal
	 * @param targetValue
	 */
	constructor(targetValue: number)

	step(state: InstantState, deltaTime: number): InstantState
}