interface SpringState {
	complete: boolean,
	position: number,
	velocity: number
}

export default class Spring {
	/**
	 * Creates a new Spring goal
	 * @param targetValue
	 * @param options 
	 */
	constructor(targetValue: number, options?: {
		frequency?: number,
		dampingRatio?: number
	})
	
	step(state: SpringState, deltaTime: number): SpringState
}