instance creation
for: anEncoding

	anEncoding isSymbol ifFalse: [ ^anEncoding streamingAsEncoder ].
	^Encoders at: anEncoding ifAbsent: [
		DialectEncoder
			ifNil: [ self error: 'Unknown encoding!' ]
			ifNotNil: [ :factory | factory for: anEncoding ] ]