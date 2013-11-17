"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
