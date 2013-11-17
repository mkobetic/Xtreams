"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: compressing
"
trim
	| read write |
	read := (dataPosition + readPosition) \\ cache size.
	write := (dataPosition + writePosition) \\ cache size.
	read <= write
		ifTrue: [cache := cache copyFrom: read + 1 to: write + 1]
		ifFalse:
			[ | replacement readSize |
			readSize := cache size - read.
			replacement := cache copyEmpty: write + readSize.
			replacement replaceFrom: 1 to: readSize with: cache startingAt: read + 1.
			replacement replaceFrom: readSize + 1 to: replacement size with: cache startingAt: write + 1.
			cache := replacement].
	dataPosition := readPosition := 0.
	dataLength := writePosition := cache size
