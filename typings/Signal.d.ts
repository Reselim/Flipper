export class Connection {
	/**
	 * Creates a new Connection
	 * @param signal Signal that this connection originates from
	 * @param handler Function to be called whenever signal is activated
	 */
	constructor(signal: Signal, handler: Callback)

	/**
	 * Signal that this connection originates from
	 */
	signal: Signal

	/**
	 * Whether the connection is still connected or not
	 */
	connected: boolean

	/**
	 * Disconnects the connection from its' source signal
	 */
	disconnect(): void
}

export declare class Signal<T = Callback> {
	/**
	 * Creates a new Signal
	 */
	constructor()

	/**
	 * Calls all handlers connected to the signal
	 * @param args Arguments to call the handlers with
	 */
	fire(...args: FunctionArguments<T>): void

	/**
	 * Connects a handler function so that whenever .fire() is called, the function is invoked
	 * @param handler Function to call whenever the signal is fired
	 */
	connect(handler: (...args: FunctionArguments<T>) => void): Connection

	/**
	 * Pauses the current thread until the signal is fired
	 */
	wait(): FunctionArguments<T>
}
