"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingInsert: anInteger into: aWriteStream
	| count amount |

	count := 0.
	[count < anInteger and: [buffer hasDataToRead or: [substreamAtEnd not]]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		buffer hasDataToRead ifFalse: [(Incomplete count: count) raise].
		amount := buffer readSize min: (anInteger - count).
		aWriteStream insert: amount from: buffer.
		count := count + amount].
	count < anInteger ifTrue: [(Incomplete count: count) raise]
