"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: substreaming
"
limiting: limit
	"Create a substream that will allow at most @limit number of elements to be read from the source."
	"       limit           <Integer>       maximum number of elements that can be read from the source
		^<LimitReadStream>"
	"
		('abcdefghi' reading limiting: 5) rest
	"
	^LimitReadSubstream on: self limit: limit
