"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
