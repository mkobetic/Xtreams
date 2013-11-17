"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count amount |

	count := 0.
	[count < anInteger and: [buffer hasDataToRead or: [substreamAtEnd not]]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		buffer hasDataToRead ifFalse: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		amount := buffer readSize min: (anInteger - count).
		buffer read: amount into: aSequenceableCollection at: startIndex + count.
		count := count + amount].
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
