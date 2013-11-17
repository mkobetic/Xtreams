"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: substreaming
"
ending: aMatchable
	"Creates a substream that will end when aMatchable finds a match in the content passing through. aMatchable is either
		* a block that is evaluated with each element; the stream ends when the block returns true
		* a collection that is matched against the last elements read, the stream ends when the collection matches
		* any other object, the stream matches when an equal object is read from the stream"
	"       aMatchable      <BlockClosure | Collection | Object>
		^<TransformReadStream>
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: $j) rest.
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: 'mno') rest
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: [ :e | 'gmt' includes: e ]) rest
	"
	^self ending: aMatchable inclusive: false
