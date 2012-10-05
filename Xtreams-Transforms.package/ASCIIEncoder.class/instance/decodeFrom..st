accessing
decodeFrom: aReadStream

	| value |
	^(value := aReadStream get) < 128
		ifTrue: [ Character value: value ]
		ifFalse: [ self error: 'Illegal value!' ]