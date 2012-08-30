accessing
digestSize
	
	^algorithm
		ifNil: [0]
		ifNotNil: [algorithm md_size]