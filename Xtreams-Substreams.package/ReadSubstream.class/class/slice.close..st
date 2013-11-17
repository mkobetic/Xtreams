"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
slice: sliceBlock close: closeBlock
	| substream |
	substream := nil.
	^[substream == nil ifFalse:
		[substream substreamClosed ifFalse: [substream close].
		substream subseekend.
		substream sourceAtEnd ifTrue: [Incomplete zero raise]].
	substream := sliceBlock value]
		reading
			closeBlock: closeBlock;
			yourself
