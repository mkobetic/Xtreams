"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWrite: anInteger into: aWriteStream
	| amount |
	collection ifNil: [(self class on: collection count: 0 at: start) raise].
	amount := anInteger min: count.
	aWriteStream write: amount from: collection at: start.
	amount < anInteger ifTrue: [(self class on: collection count: amount at: start) raise].
	^anInteger