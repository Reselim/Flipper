interface LinearState {
	complete: boolean
	position: number
	velocity: number
}

interface LinearOptions {
	velocity?: number
}

declare interface Linear {
	step(state: LinearState, deltaTime: number): LinearState
}

declare interface LinearConstructor {
	new(targetValue: number, options?: LinearOptions): Linear
}

declare const Linear: LinearConstructor
export = Linear