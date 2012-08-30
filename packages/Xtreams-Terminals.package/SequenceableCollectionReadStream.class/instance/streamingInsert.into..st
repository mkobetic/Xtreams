private
streamingInsert: anInteger into: aWriteStream
	| count |
	anInteger isZero ifTrue: [^self].
	count := anInteger min: self available.
	aWriteStream insert: count from: source at: position + 1.
	position := position + count.
	count >= anInteger ifTrue: [^self].
	(Incomplete on: source count: count at: position - count + 1) raise