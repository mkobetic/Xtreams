"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: instance creation
"
for: anEncoding

	anEncoding isSymbol ifFalse: [ ^anEncoding streamingAsEncoder ].
	^Encoders at: anEncoding ifAbsent: [
		DialectEncoder
			ifNil: [ self error: 'Unknown encoding!' ]
			ifNotNil: [ DialectEncoder for: anEncoding ] ]
