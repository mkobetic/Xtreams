private
streamingWrite: anInteger from: aReadStream
	| cache toDo continue amount |
	cache := self contentsSpecies newRecycledDefaultSize.
	toDo := anInteger. continue := true.
	[ continue and: [ toDo > 0 ] ] whileTrue: [
		amount := [ aReadStream read: (cache size min: toDo) into: cache at: 1 ] on: Incomplete do: [ :ex | continue := false. ex count ].
		self write: amount from: cache at: 1.
		toDo := toDo - amount ].
	cache recycle.
	toDo > 0 ifTrue: [(Incomplete count: anInteger - toDo) raise].
	^anInteger