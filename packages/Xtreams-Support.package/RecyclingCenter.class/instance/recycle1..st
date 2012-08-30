recycling
recycle1: aCollection
	aCollection class isPointers ifTrue: [aCollection at: 1 put: nil].
	self recycle: aCollection