seeking
-= anInteger
	^anInteger isZero
		ifTrue:	[self subseekend. 0]
		ifFalse:	[super -= anInteger]