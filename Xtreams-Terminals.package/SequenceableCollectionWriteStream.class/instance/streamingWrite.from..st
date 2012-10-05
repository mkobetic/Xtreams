private
streamingWrite: anInteger from: aReadStream
	| available |
	available := destination size - position.
	available < anInteger ifTrue: [destination := destination grownBy: (destination size max: anInteger - available)].
	[aReadStream read: anInteger into: destination at: position + 1]
		on: Incomplete do: [:error |
			position := position + error count.
			position > length ifTrue: [length := position].
			error pass].
	position := position + anInteger.
	position > length ifTrue: [length := position].
	^anInteger