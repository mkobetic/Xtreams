"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count amount |

	count := 0.
	[count < anInteger and: [outputBuffer hasDataToRead or: [substreamAtEnd not]]] whileTrue:
		[outputBuffer hasDataToRead ifFalse: [self gobble].
		amount := outputBuffer readSize min: (anInteger - count).
		amount > 0 ifTrue: [outputBuffer read: amount into: aSequenceableCollection at: startIndex + count].
		count := count + amount].
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger