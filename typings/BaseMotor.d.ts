import { Connection } from "./Signal"

export default class BaseMotor {
	/**
	 * Creates a new BaseMotor
	 */
	constructor()

	/**
	 * Connects a function to be called whenever the motor updates
	 * @param handler
	 */
	onStep(handler: (value: unknown) => void): Connection
	
	/**
	 * Connects a function to be called whenever the motor completes
	 * @param handler
	 */
	onComplete(handler: () => void): Connection

	/**
	 * Hooks up a connection to RunService.RenderStepped
	 * 
	 * You shouldn't need to use this.
	 */
	start(): void

	/**
	 * Removes the connection defined by .start(), if it exists
	 */
	stop(): void

	/**
	 * Alias for .stop()
	 */
	destroy(): void

	/**
	 * Advances the motor further in time by the specified amount
	 * @returns Indicator to whether the motor is complete or not
	 */
	step(deltaTime: number): boolean
}