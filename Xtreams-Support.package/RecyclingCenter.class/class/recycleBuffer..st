recycling
recycleBuffer: aBuffer
	aBuffer == nil ifTrue: [^nil].
	self recycle: aBuffer cache