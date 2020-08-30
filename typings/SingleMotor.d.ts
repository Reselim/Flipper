import BaseMotor from "./BaseMotor"

export default class SingleMotor extends BaseMotor {
	/**
	 * Creates a new SingleMotor
	 * @param initialValue Value to set the motor to initially
	 * @param useImplicitConnections Should this motor manage RenderStepped connections automatically?
	 */
	constructor(initialValue: number, useImplicitConnections?: number)

	/**
	 * TODO
	 * @returns The current value of the motor
	 */
	getValue(): number

	/**
	 * TODO
	 * @param goal 
	 */
	setGoal(goal: any): void
}