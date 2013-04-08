"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex
	| count amount written offset |
	count := 0.
	offset := startIndex.
	[count < anInteger] whileTrue:
		[amount := anInteger min: cache size.
		1 to: amount do: [:index | cache at: index put: (block value: (aSequenceableCollection at: offset+index))].
		written := [destination insert: anInteger from: cache. amount] on: Incomplete do: [ :ex | ex count ].
		count := count + written.
		written < amount ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		offset := offset + amount ].
	^anInteger