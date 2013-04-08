This is an external stream with built in timeout support. A write operation will signal a Timeout if there is no room to write the pending data (usually because the other side didn't read what was already written yet so associated buffers are still full) for longer than the preconfigured timeout duration. The Timeout exception is resumable which will make the operation continue to wait for another timeout period.

Instance Variables
	timeout	<Duration> how long we're willing to wait for room to write data

