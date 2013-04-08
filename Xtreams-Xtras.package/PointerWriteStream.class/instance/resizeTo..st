"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
resizeTo: anInteger
	| replacement beGC |
	length = anInteger ifTrue: [^self].
	replacement := destination type baseReferentType malloc: anInteger.
	OSSystemSupport concreteClass new copyMemoryTo: replacement from: destination size: (length min: anInteger).
	beGC := CPointer.GarbageCollectablePointers includes: destination.
	destination free.
	destination referentAddress: replacement referentAddress.
	beGC ifTrue: [destination beGarbageCollectable].
	length := anInteger