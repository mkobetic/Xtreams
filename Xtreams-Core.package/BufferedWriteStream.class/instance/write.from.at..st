"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex

	| count amount |
	count := 0.
	[[amount := buffer write: (buffer writeSize min: (anInteger - count)) from: aSequenceableCollection at: startIndex + count.
	count := count + amount.
	count < anInteger] whileTrue: [self flush]]
		on: Incomplete do: [:exception | (Incomplete on: aSequenceableCollection count: count + exception count at: startIndex) raise].
	^anInteger