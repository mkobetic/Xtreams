"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
startingAt: repStart replaceElementsIn: collection from: start to: stop
	"This destructively replaces elements from start to stop in the 
	collection starting at index, repStart, in the receiver. 
	Answer the collection."

	^collection
		replaceElementsFrom: start
		to: stop
		withInterpretedBytes: self startingAt: repStart