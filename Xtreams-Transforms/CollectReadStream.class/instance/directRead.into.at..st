"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: private
"
directRead: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := [source read: anInteger into: aSequenceableCollection at: startIndex. anInteger] on: Incomplete do: [ :ex | ex count ].
	startIndex to: startIndex + count - 1 do: [:index | aSequenceableCollection at: index put: (block value: (aSequenceableCollection at: index))].
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise]
