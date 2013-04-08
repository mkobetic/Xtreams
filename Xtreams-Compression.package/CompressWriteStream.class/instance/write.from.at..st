"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex

	| count index |
	anInteger isZero ifTrue: [^self].
	count := anInteger.
	index := startIndex.
	[	| available |
		available := count min: input size.
		input replaceFrom: 1 to: available with: aSequenceableCollection startingAt: index.
		count := count - available.
		index := index + available.
		compression update: available from: input into: output do: [ :in :out |
			destination write: out from: output at: 1.
			in < available ].
		count > 0
	] whileTrue.
	^anInteger