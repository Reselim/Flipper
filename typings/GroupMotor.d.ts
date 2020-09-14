import BaseMotor from "./BaseMotor"
import Instant from "./Instant"
import Spring from "./Spring"

// Infers the type for setGoal
type GroupMotorGoals<T> = T extends Array<number> ? 
	Array<Spring | Instant>
	: T extends {[name: string]: number} ?
	{[P in keyof T]: Spring | Instant}
	: never

declare interface GroupMotor<T> extends BaseMotor<T> {
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
	new<T extends Array<number> | {[name: string]: number}>(initialValues: T, useImplicitConnections?: boolean): GroupMotor<T>
}

declare const GroupMotor: GroupMotorConstructor
export = GroupMotor