"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	| count index |
	count := 0.
	index := startIndex.
	[[count < anInteger and: [substreamAtEnd not]] whileTrue:
		[count := count + (self gobble: (aSequenceableCollection at: index)).
		index := index + 1]]
			on: Incomplete do: [:incomplete |
				destinationAtEnd := substreamAtEnd := true.
				(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	count < anInteger ifTrue:
		[substreamAtEnd := true.
		(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger