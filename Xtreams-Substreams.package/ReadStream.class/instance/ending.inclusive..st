"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: substreaming
"
ending: aMatchable inclusive: inclusive
	"Creates a substream that will end when aMatchable finds a match in the content passing through. aMatchable is either
		* a block that is evaluated with each element - the stream ends when the block returns true
		* a collection that is matched against the last elements read - the stream ends when the collection matches
		* any other object - the stream matches when an equal object is read from the stream
	The inclusive parameter determins if the elements matching the end condition should be included in the substream contents or not."
	"       aMatchable      <BlockClosure | Collection | Object>    the substream ending criteria
		inclusive       <Boolean> should the content matching the end condition be included in the substream
		^<TransformReadStream>
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: $j inclusive: true) rest.
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: 'mno' inclusive: true) rest
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: [ :e | 'gmt' includes: e ] inclusive: true) rest
	"
	^aMatchable streamingReadMatching: self inclusive: inclusive
