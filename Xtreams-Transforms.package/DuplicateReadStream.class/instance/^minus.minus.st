"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-- anInteger
	^self isPositionable
		ifFalse: [super -- anInteger]
		ifTrue:
			[source -- anInteger.
			duplicate -- anInteger]