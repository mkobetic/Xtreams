"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: substreaming
"
ending: aMatchable
	"Creates a substream that will end when aMatchable finds a match in the content passing through. aMatchable is either
		* a block that is evaluated with each element - the stream ends when the block returns true
		* a collection that is matched against the last elements written - the stream ends when the collection matches
		* any other object - the stream ends when an equal object is written into the stream"
	"	aMatchable	<BlockClosure | Collection | Object> the substream ending criteria
		^<TransformWriteStream>
	""	
		| stream slice |
		stream := String new writing.
		slice := stream ending: $j.
		[ slice write: 'abcdefghijklmnopqrstuvxyz' ] on: Incomplete do: [].
		stream conclusion
	""
		| stream slice |
		stream := String new writing.
		slice := stream ending: 'mno'.
		[ slice write: 'abcdefghijklmnopqrstuvxyz' ] on: Incomplete do: [].
		stream conclusion
	""
		| stream slice |
		stream := String new writing.
		slice := stream ending: [ :e | 'gmt' includes: e ].
		[ slice write: 'abcdefghijklmnopqrstuvxyz' ] on: Incomplete do: [].
		stream conclusion
	"
	^self ending: aMatchable inclusive: false