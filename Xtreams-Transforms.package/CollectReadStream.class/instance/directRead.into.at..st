"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
directRead: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := [source read: anInteger into: aSequenceableCollection at: startIndex. anInteger] on: Incomplete do: [ :ex | ex count ].
	startIndex to: startIndex + count - 1 do: [:index | aSequenceableCollection at: index put: (block value: (aSequenceableCollection at: index))].
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise]