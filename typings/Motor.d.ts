import type Types from "./Types"

import { GroupMotorClass } from "./GroupMotor"
import { SingleMotorClass } from "./SingleMotor"


declare interface MotorConstructor {
	/**
	 * Creates a new SingleMotor or GroupMotor based on the parameters
	 * @param initialValues Value to set the motor to initially
	 * @param useImplicitConnections Should this motor manage RenderStepped connections automatically?
	 */
	new<T extends Types>(initialValues: T, useImplicitConnections?: boolean): T extends number ? SingleMotorClass : GroupMotorClass<T>
}

declare const Motor: MotorConstructor
export = Motor
