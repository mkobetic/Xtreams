"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
replaceElementsFrom: start to: stop withInterpretedBytes: replacement startingAt: repStart 
	"This destructively replaces elements from start to stop in the 
	receiver starting at index, repStart, in the collection, replacement. 
	Answer the receiver."

	^self replaceFrom: start to: stop with: replacement startingAt: repStart