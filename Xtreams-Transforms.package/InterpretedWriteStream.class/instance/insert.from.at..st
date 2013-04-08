"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex

	| count amount |
	count := 0.
	[count = anInteger] whileFalse: 
		[amount := cacheSize min: anInteger - count.
		0 to: amount - 1 do:  [:index | operation value: cache value: index * elementSize + 1 value: (aSequenceableCollection at: index + startIndex)].
		destination insert: amount * elementSize from: cache at: 1.
		count := count + amount].
	^anInteger