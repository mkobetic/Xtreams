"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| object count |

	substreamAtEnd ifTrue: [(Incomplete on: aSequenceableCollection count: 0 at: startIndex) raise].
	count := 0.
	[[count = anInteger or: [substreamAtEnd]] whileFalse:
		[object := source get.
		((substreamAtEnd := test value: object) not or: [inclusive]) ifTrue:
			[aSequenceableCollection at: startIndex + count put: object.
			count := count + 1]]]
				on: Incomplete do: [sourceAtEnd := substreamAtEnd := true. (Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
