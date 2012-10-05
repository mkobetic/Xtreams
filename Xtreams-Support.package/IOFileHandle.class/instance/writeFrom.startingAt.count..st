read, write, position
writeFrom: buffer startingAt: index count: num
	"Answer the number of bytes written"
	writable ifFalse: [self error: 'Cannot write a read-only file'. ^ 0].
	^self primWrite: self handle from: buffer startingAt: index count: num.