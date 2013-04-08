"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
length
	"advance to the end"
	[ [ self ++ SmallInteger maxVal ] repeat ] on: Incomplete do: [ :ex | ].
	^buffer activeSize