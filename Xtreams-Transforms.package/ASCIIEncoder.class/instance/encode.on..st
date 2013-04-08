"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
encode: aCharacter on: aWriteStream

	| value |
	(value := aCharacter asInteger) < 128
		ifTrue: [ aWriteStream put: value ]
		ifFalse: [ self error: 'Illegal character!' ]