private
streamingWriteFrom: aReadStream
	| available count chunkSize |
	count := 0.
	chunkSize := DefaultBufferSize.
	^[[available := destination size - position.
	available < chunkSize ifTrue: [destination := destination grownBy: (destination size max: chunkSize)].
	aReadStream read: chunkSize into: destination at: position + 1.
	position := position + chunkSize.
	count := count + chunkSize] repeat]
		on: Incomplete do: [:exception |
			position := position + exception count.
			position > length ifTrue: [length := position].
			count + exception count]