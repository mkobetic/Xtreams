"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
get
	"Read an object from self.
	If there aren't any elements left in the stream, the Incomplete exception is raised."
	"       ^       <Object> an object read from this stream
	"
	| cache object |
	cache := self contentsSpecies newRecycled: 1.
	self read: 1 into: cache at: 1.
	object := cache first.
	cache recycle.
	^object
