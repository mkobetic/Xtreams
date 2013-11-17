"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingWrite: anInteger from: aReadStream
	| available |
	available := destination size - position.
	available < anInteger ifTrue: [destination := destination copyGrownToAtLeast: destination size + anInteger - available].
	[aReadStream read: anInteger into: destination at: position + 1]
		on: Incomplete do: [:error |
			position := position + error count.
			position > length ifTrue: [length := position].
			error pass].
	position := position + anInteger.
	position > length ifTrue: [length := position].
	^anInteger
