import { Spring, Instant } from "."
import BaseMotor from "./BaseMotor"

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