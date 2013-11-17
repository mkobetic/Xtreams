"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingInsert: anInteger into: aWriteStream
	| count |
	anInteger isZero ifTrue: [^self].
	count := anInteger min: self available.
	aWriteStream insert: count from: source at: position + 1.
	position := position + count.
	count >= anInteger ifTrue: [^self].
	(Incomplete on: source count: count at: position - count + 1) raise
