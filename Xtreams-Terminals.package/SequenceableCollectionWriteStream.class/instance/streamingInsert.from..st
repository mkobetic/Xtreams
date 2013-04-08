"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsert: anInteger from: aStreamable
	| reading |
	reading := aStreamable reading.
	destination growToAtLeast: destination size + anInteger.
	destination replaceFrom: position + anInteger to: destination size with: destination startingAt: position.
	[reading read: anInteger into: destination at: position + 1]
		on: Incomplete do: [:error | position := position + error count. error pass].
	position := position + anInteger