private
streamingInsert: anInteger into: aWriteStream
	| amount |
	collection ifNil: [(Incomplete on: collection count: 0 at: start) raise].
	amount := anInteger min: count.
	aWriteStream insert: amount from: collection at: start.
	amount < anInteger ifTrue: [(Incomplete on: collection count: amount at: start) raise].