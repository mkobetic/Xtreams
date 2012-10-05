read, write, position
readInto: buffer
	"Answer the number of bytes read"
	^self primRead: self handle into: buffer startingAt: 1 count: buffer size