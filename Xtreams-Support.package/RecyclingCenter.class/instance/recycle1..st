"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: recycling
"
recycle1: aCollection
	aCollection class isPointers ifTrue: [aCollection at: 1 put: nil].
	self recycle: aCollection