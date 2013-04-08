"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
replaceElementsFrom: start to: stop withInterpretedBytes: replacement startingAt: repStart 
	"This destructively replaces elements from start to stop in the 
	receiver starting at index, repStart, in the collection, replacement. 
	Answer the receiver. No range checks are performed, but 
	overlapping replacements are handled correctly."

	| repOff |
	repOff := repStart - start.
	(self == replacement and: [repStart < start])
		ifTrue: ["Replacement would be overwritten, copy in reverse order."
				stop to: start by: -1
					do: [:index | self at: index put: (replacement byteAt: repOff + index)]]
		ifFalse: [start to: stop
					do: [:index | self at: index put: (replacement byteAt: repOff + index)]]