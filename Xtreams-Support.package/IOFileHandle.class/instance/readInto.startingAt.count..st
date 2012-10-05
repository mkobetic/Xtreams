read, write, position
readInto: buffer startingAt: index count: num
	"Answer the number of bytes read"
	^self primRead: self handle into: buffer startingAt: index count: num