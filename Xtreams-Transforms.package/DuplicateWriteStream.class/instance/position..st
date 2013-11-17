"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
position: anInteger
	^self isPositionable
		ifFalse: [super position: anInteger]
		ifTrue:
			[destination position: anInteger.
			duplicate position: anInteger]