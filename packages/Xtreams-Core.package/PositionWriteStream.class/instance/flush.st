initialize-release
flush
	buffer ifNil: [^self].
	destination write: buffer.
	buffer clear