*Xtreams-Substreams-substreaming
limiting: limit
	"Create a substream that will allow at most @limit number of elements written into the destination."
	"	limit	<Integer>	maximum number of elements that can be written into destination
		^<LimitWriteStream>"
	"
		| stream slice |
		stream := String new writing.
		slice := stream limiting: 5.
		[ slice write: 'abcdefghi' ] on: Incomplete do: [].
		stream conclusion
	"

	^XTLimitWriteSubstream on: self limit: limit