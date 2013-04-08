"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
copyFrom: start to: stop 
	"Answer a copy of a subset of the receiver, starting from element at index start 
	until element at index stop."

	| newSize |
	newSize := stop - start + 1.
	^(ByteArray withSize: newSize)
		replaceFrom: 1
		to: newSize
		with: self
		startingAt: start