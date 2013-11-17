"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
decodeFrom: aReadStream

	| value |
	^(value := aReadStream get) < 128
		ifTrue: [ Character value: value ]
		ifFalse: [ self error: 'Illegal value!' ]
