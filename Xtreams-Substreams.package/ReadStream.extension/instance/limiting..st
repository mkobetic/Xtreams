*Xtreams-Substreams-substreaming
limiting: limit
	"Create a substream that will allow at most @limit number of elements to be read from the source."
	"	limit		<Integer>	maximum number of elements that can be read from the source
		^<LimitReadStream>"
	"
		('abcdefghi' reading limiting: 5) rest
	"
	^XTLimitReadSubstream on: self limit: limit