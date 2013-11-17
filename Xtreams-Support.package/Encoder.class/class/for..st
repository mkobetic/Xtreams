"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: instance creation
"
for: anEncoding

	anEncoding isSymbol ifFalse: [ ^anEncoding streamingAsEncoder ].
	^Encoders at: anEncoding ifAbsent: [
		DialectEncoder
			ifNil: [ self error: 'Unknown encoding!' ]
			ifNotNil: [ DialectEncoder for: anEncoding ] ]
