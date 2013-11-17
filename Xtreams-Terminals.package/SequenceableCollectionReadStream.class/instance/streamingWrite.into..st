"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWrite: anInteger into: aWriteStream
	| count |
	anInteger isZero ifTrue: [^0].
	count := anInteger min: self available.
	aWriteStream write: count from: source at: position + 1.
	position := position + count.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete on: source count: count at: position - count + 1) raise
