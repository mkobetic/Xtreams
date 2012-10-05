private
drainBuffer
	| reading |
	process ifNotNil: [process terminate].
	incompleteCount == nil ifFalse: [^self].

	closeReady := Semaphore new.
	readReady := Semaphore new.
	writeReady := Semaphore new.
	reading := buffer reading transforming: [:in :out |
		| count |
		"Wait for the main process to have written to the buffer"
		readReady wait.

		"If nothing was written to the buffer, this indicates we're closing, we raise Incomplete"
		(count := buffer readSize) isZero ifTrue: [Incomplete zero raise].
		out write: count from: in.

		"Allow the main process to write to the buffer"
		writeReady signal].
	process := [
		[[block value: reading value: destination] repeat] on: Incomplete do: [:ex |].
		incompleteCount := reading buffer readPosition.

		"Signal that we're closed so that an attempt to write or close will immediately complete"
		writeReady signal.
		closeReady signal]
			newProcess.
	process resume