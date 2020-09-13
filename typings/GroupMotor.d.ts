import Spring from "./Spring";
import BaseMotor from "./BaseMotor";
import Instant from "./Instant";

// Infers the type for setGoal
type GroupMotorGoals<T> = T extends Array<number> ? Array<Spring | Instant> : T extends object ? {[P in keyof T]: Spring | Instant} : never; 

export default class GroupMotor<T extends Array<number> | {[name: string]: number}> extends BaseMotor<T> {
	/**
	 * Creates a new GroupMotor
	 * @param initialValues Value to set the motor to initially
	 * @param useImplicitConnections Should this motor manage RenderStepped connections automatically?
	 */
	constructor(initialValues: T, useImplicitConnections?: boolean)

	/**
	 * TODO
	 */
	getValue(): T;

	/**
	 * TODO
	 * @param goals 
	 */
	setGoal(goals: GroupMotorGoals<T>): void;
}