"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
length
	"advance to the end"
	[ [ self ++ SmallInteger maxVal ] repeat ] on: Incomplete do: [ :ex | ].
	^buffer activeSize
