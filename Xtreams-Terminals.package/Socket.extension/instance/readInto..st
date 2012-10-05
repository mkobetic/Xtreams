*Xtreams-Terminals
readInto: buffer
	"Only read available data - no wait.
	Answer number of bytes read."
	^self receiveDataInto: buffer startingAt: 1