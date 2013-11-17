"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex

	| count amount |
	count := 0.
	[count = anInteger] whileFalse: 
		[amount := cacheSize min: anInteger - count.
		0 to: amount - 1 do:  [:index | operation value: cache value: index * elementSize + 1 value: (aSequenceableCollection at: count + index + startIndex)].
		destination write: amount * elementSize from: cache at: 1.
		count := count + amount].
	^anInteger