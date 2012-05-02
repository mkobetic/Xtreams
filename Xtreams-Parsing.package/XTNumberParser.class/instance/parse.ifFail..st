public
parse: aReadable ifFail: aBlock
	^ self parse: aReadable base: 10 ifFail: aBlock