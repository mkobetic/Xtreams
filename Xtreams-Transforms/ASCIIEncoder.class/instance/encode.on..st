"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
encode: aCharacter on: aWriteStream

	| value |
	(value := aCharacter asInteger) < 128
		ifTrue: [ aWriteStream put: value ]
		ifFalse: [ self error: 'Illegal character!' ]
