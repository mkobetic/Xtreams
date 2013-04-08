"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWrite: anInteger into: aWriteStream
	| count amount |

	count := 0.
	[count < anInteger and: [outputBuffer hasDataToRead or: [substreamAtEnd not]]] whileTrue:
		[outputBuffer hasDataToRead ifFalse: [self gobble].
		amount := outputBuffer readSize min: (anInteger - count).
		amount > 0 ifTrue: [aWriteStream write: amount from: outputBuffer].
		count := count + amount].
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger