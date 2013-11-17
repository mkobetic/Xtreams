"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-= anInteger
	^anInteger isZero
		ifTrue: [self subseekend. 0]
		ifFalse:        [super -= anInteger]
