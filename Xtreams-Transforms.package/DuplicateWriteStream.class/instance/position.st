"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
position
	^self isPositionable
		ifFalse: [super position]
		ifTrue: [destination position]