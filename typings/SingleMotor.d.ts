import Instant from "./Instant";
import Spring from "./Spring";
import BaseMotor from "./BaseMotor"

export default class SingleMotor extends BaseMotor<number> {
	/**
	 * Creates a new SingleMotor
	 * @param initialValue Value to set the motor to initially
	 * @param useImplicitConnections Should this motor manage RenderStepped connections automatically?
	 */
	constructor(initialValue: number, useImplicitConnections?: boolean)

	/**
	 * TODO
	 * @returns The current value of the motor
	 */
	getValue(): number;

	/**
	 * TODO
	 * @param goal 
	 */
	setGoal(goal: Spring | Instant): void;
}