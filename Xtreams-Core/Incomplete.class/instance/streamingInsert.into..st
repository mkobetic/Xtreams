"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingInsert: anInteger into: aWriteStream
	| amount |
	collection ifNil: [(self class on: collection count: 0 at: start) raise].
	amount := anInteger min: count.
	aWriteStream insert: amount from: collection at: start.
	amount < anInteger ifTrue: [(self class on: collection count: amount at: start) raise].
