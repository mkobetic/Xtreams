seeking
length
	"advance to the end"
	[ [ self ++ SmallInteger maxVal ] repeat ] on: Incomplete do: [ :ex | ].
	^buffer activeSize