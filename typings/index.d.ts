import { SingleMotor } from "./SingleMotor"
import { GroupMotor } from "./GroupMotor"
import Motor from "./Motor"

import Instant from "./Instant"
import Linear from "./Linear"
import Spring from "./Spring"

declare function isMotor(value: any): boolean

export {
	SingleMotor,
	GroupMotor,
	Motor,

	Instant,
	Linear,
	Spring,

	isMotor
}
