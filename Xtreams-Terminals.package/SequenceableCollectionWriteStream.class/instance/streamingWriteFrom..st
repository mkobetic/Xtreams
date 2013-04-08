"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteFrom: aReadStream
	| available count |
	count := 0.
	destination size = 0 ifTrue: [ destination growToAtLeast: DefaultBufferSize ].
	^[	[	available := destination size - position.
			aReadStream read: available into: destination at: position + 1.
			position := position + available.
			count := count + available.
			destination growToAtLeast: destination size + (destination size min: DefaultBufferSize)
		] repeat
	] on: Incomplete do: [:exception |
		position := position + exception count.
		position > length ifTrue: [length := position].
		count + exception count]