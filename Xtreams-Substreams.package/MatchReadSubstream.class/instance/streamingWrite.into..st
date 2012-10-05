private
streamingWrite: anInteger into: aWriteStream
	| count amount |

	count := 0.
	[count < anInteger and: [buffer hasDataToRead or: [substreamAtEnd not]]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		buffer hasDataToRead ifFalse: [(Incomplete count: count) raise].
		amount := buffer readSize min: (anInteger - count).
		aWriteStream write: amount from: buffer.
		count := count + amount].
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger