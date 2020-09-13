interface SpringState {
	complete: boolean,
	position: number,
	velocity: number
}

interface SpringOptions {
	frequency?: number;
	dapingRatio?: number;
}

declare interface Spring {
	step(state: SpringState, deltaTime: number): SpringState
}

declare interface SpringConstructor {
	new(targetValue: number, options?: SpringOptions): Spring;
}

declare const Spring: SpringConstructor;
export = Spring;