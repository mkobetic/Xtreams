"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex

	[	source read: anInteger into: aSequenceableCollection at: startIndex.
	] on: Incomplete do: [ :incomplete |
		duplicate write: incomplete count from: aSequenceableCollection at: startIndex.
		incomplete pass ].
	duplicate write: anInteger from: aSequenceableCollection at: startIndex
