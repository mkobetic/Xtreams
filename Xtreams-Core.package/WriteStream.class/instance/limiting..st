"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: substreaming
"
limiting: limit
	"Create a substream that will allow at most @limit number of elements written into the destination."
	"       limit   <Integer>       maximum number of elements that can be written into destination
		^<LimitWriteStream>"
	"
		| stream slice |
		stream := String new writing.
		slice := stream limiting: 5.
		[ slice write: 'abcdefghi' ] on: Incomplete do: [].
		stream conclusion
	"

	^LimitWriteSubstream on: self limit: limit
