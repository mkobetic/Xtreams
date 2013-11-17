"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingWriteFrom: aReadStream
	| available count chunkSize |
	count := 0.
	chunkSize := DefaultBufferSize.
	^[[available := destination size - position.
	available < chunkSize ifTrue: [destination := destination copyGrownToAtLeast: destination size + chunkSize].
	aReadStream read: chunkSize into: destination at: position + 1.
	position := position + chunkSize.
	count := count + chunkSize] repeat]
		on: Incomplete do: [:exception |
			position := position + exception count.
			position > length ifTrue: [length := position].
			count + exception count]
