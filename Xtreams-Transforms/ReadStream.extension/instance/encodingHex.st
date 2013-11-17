"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: transforming
"
encodingHex
	"Decodes bytes hex characters."
	"	^<TransformReadStream>"
	"
		(ByteArray withAll: (1 to: 20)) reading encodingHex rest
	"
	| i2c |
	i2c := [ :i | '0123456789abcdef' at: i + 1 ].
	^(self transforming: [ :in :out || byte |
		byte := in get.
		out put: (i2c value: (byte bitShift: -4)).
		out put: (i2c value: (byte bitAnd: 15)) ])
		contentsSpecies: ByteString;
		yourself
