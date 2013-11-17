"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[[count < anInteger] whileTrue:
		[aSequenceableCollection at: startIndex + count put: source value.
		count := count + 1]]
			on: Incomplete do: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
