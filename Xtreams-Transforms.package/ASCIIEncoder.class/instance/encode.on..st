accessing
encode: aCharacter on: aWriteStream

	| value |
	(value := aCharacter asInteger) < 128
		ifTrue: [ aWriteStream put: value ]
		ifFalse: [ self error: 'Illegal character!' ]