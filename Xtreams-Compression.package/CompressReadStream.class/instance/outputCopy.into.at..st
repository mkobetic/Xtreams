"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
outputCopy: requested into: target at: start  

	| copied |
	unconsumedOut isZero ifTrue: [ ^0 ].
	copied := unconsumedOut min: requested.
	target replaceFrom: start to: start + copied - 1 with: output startingAt: 1.
	unconsumedOut :=
		unconsumedOut > copied
			ifTrue: [ "if there was more than was requested, realign the ouput buffer and exit"
				output replaceFrom: 1 to: unconsumedOut - copied with: output startingAt: copied + 1.
				unconsumedOut - copied ]
			ifFalse: [ 0 ].
	^copied