"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: substreaming
"
slicing
	"From a writable stream, return a readable stream that acts as a prototype factory for the writable stream."
	"	^<ReadStream>"
	"(destination limiting: 10) slicing"

	| substream |
	substream := nil.
	^[substream == nil ifFalse:
		[substream close.
		substream destinationAtEnd ifTrue: [Incomplete zero raise]].
		substream := self copy]
		reading
			closeBlock: [
				substream == nil ifFalse: [
					substream close.
					substream := nil].
				destination close];
			yourself