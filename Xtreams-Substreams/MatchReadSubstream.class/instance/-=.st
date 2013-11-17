"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
-= anInteger
	^anInteger isZero
		ifTrue: [self subseekend. 0]
		ifFalse:        [super -= anInteger]
