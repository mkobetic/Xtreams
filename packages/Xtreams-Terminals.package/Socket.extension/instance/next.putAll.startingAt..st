*Xtreams-Terminals
next: count putAll: buffer startingAt: startIndex
	"Immediately send data (no wait).
	Answer number of bytes written."
	self isConnected ifFalse: [^0].
	^self sendSomeData: buffer startIndex: startIndex count: count