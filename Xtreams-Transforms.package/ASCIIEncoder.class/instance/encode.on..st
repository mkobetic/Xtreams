"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
encode: aCharacter on: aWriteStream

	| value |
	(value := aCharacter asInteger) < 128
		ifTrue: [ aWriteStream put: value ]
		ifFalse: [ self error: 'Illegal character!' ]
