"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
decodeFrom: aReadStream

	| value |
	^(value := aReadStream get) < 128
		ifTrue: [ Character value: value ]
		ifFalse: [ self error: 'Illegal value!' ]