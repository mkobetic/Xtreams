"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
bufferRead: anInteger into: aSequenceableCollection at: startIndex
	| amount count read |
	count := 0.
	[count < anInteger] whileTrue:
		[amount := (anInteger - count) min: cache size.
		read := [source read: amount into: cache at: 1. amount] on: Incomplete do: [ :ex | ex count ].
		1 to: read do: [:index | aSequenceableCollection at: count + startIndex + index - 1 put: (block value: (cache at: index))].
		count := count + read.
		read < amount ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise]]
