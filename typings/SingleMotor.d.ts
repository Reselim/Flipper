import BaseMotor from "./BaseMotor"

import Spring from "./Spring"
import Instant from "./Instant"

declare interface SingleMotor extends BaseMotor<number> {

	/**
	 * TODO
	 * @returns The current value of the motor
	 */
	getValue(): number

	/**
	 * TODO
	 * @param goal 
	 */
	setGoal(goal: Spring | Instant): void
}

declare interface SingleMotorConstructor {
	/**
	 * Creates a new SingleMotor
	 * @param initialValue Value to set the motor to initially
	 * @param useImplicitConnections Should this motor manage RenderStepped connections automatically?
	 */
	new(initialValue: number, useImplicitConnections?: boolean): SingleMotor
}

declare const SingleMotor: SingleMotorConstructor
export = SingleMotor