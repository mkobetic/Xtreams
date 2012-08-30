accessing
get
	(self fillBufferIfRequired: 1) ifFalse: [Incomplete zero raise].
	^buffer get