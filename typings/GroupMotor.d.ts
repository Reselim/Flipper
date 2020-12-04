import Types from "./Types"

import BaseMotor from "./BaseMotor"

import Instant from "./Instant"
import Spring from "./Spring"

// Infers the type for setGoal
type GroupMotorGoals<T> = T extends Array<number> ?
	Array<Spring | Instant>
	: T extends {[name: string]: number} ?
	{[P in keyof T]: Spring | Instant}
	: never

declare interface GroupMotorClass<T> extends BaseMotor<T> {
	/**
	 * TODO
	 */
	getValue(): T

	/**
	 * TODO
	 * @param goals
	 */
	setGoal(goals: GroupMotorGoals<T>): void
}

declare interface GroupMotorConstructor {
	/**
	 * Creates a new SingleMotor
	 * @param initialValues Value to set the motor to initially
	 * @param useImplicitConnections Should this motor manage RenderStepped connections automatically?
	 */
	new<T extends Types>(initialValues: T, useImplicitConnections?: boolean): GroupMotorClass<T>
}

declare const GroupMotor: GroupMotorConstructor
export { GroupMotor, GroupMotorClass }
