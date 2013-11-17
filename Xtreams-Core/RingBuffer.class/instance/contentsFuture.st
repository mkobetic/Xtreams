"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
contentsFuture
	| buffer read tail |
	cache isEmpty ifTrue: [^self contentsSpecies new].
	read := (dataPosition + readPosition) \\ cache size.
	tail := (cache size - read) min: self readSize.

	buffer := self contentsSpecies withSize: self readSize.
	buffer replaceFrom: 1 to: tail with: cache startingAt: read + 1.
	buffer replaceFrom: tail + 1 to: self readSize - tail with: cache startingAt: 1.
	^buffer
