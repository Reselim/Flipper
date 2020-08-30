import SingleMotor from "./SingleMotor"
import GroupMotor from "./GroupMotor"

import Instant from "./Instant"
import Spring from "./Spring"

declare function isMotor(value: any): boolean

export {
	SingleMotor,
	GroupMotor,

	Instant,
	Spring,

	isMotor
}