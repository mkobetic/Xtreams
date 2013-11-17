"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: substreaming
"
slicing
	"From a writable stream, return a readable stream that acts as a prototype factory for the writable stream."
	"       ^<ReadStream>"
	"(destination limiting: 10) slicing"

	| substream |
	substream := nil.
	^[substream == nil ifFalse:
		[substream substreamClosed ifFalse: [substream close].
		substream subseekend.
		substream destinationAtEnd ifTrue: [Incomplete zero raise]].
		substream := self copy]
		reading
			closeBlock: [destination close];
			yourself
