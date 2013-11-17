"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: substreaming
"
slicing
	"From a readable stream, return a readable stream that acts as a prototype factory for the readable stream."
	"       ^<ReadStream>"
	"
		((1 to: 100) reading limiting: 10) slicing do: [:substream | Transcript cr; print: substream rest]
	"
	| substream |
	substream := nil.
	^[substream == nil ifFalse:
		[substream substreamClosed ifFalse: [substream close].
		substream subseekend.
		substream sourceAtEnd ifTrue: [Incomplete zero raise]].
	substream := self copy]
		reading
			closeBlock: [source close];
			yourself
