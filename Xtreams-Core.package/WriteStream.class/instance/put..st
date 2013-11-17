"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject
	"Write anObject into self."
	"       anObject                <Object>        the object to write in to the destination
		^                               <Object>        the object that was written to the destination
	""
		String new writing put: $h; close; destination
	"
	| cache |
	cache := self contentsSpecies newRecycled: 1.
	cache at: 1 put: anObject.
	self write: 1 from: cache at: 1.
	cache recycle.
	^anObject
