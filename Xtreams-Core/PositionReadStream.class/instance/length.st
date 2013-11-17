"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
length
	"advance to the end"
	[ [ self ++ SmallInteger maxVal ] repeat ] on: Incomplete do: [ :ex | ].
	^buffer activeSize
