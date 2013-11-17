"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: transforming
"
encodingHex
	"Encodes hex characters into bytes."
	"	^<TransformReadStream>"
	"
		ByteArray new writing encodingHex write: '010203fdfeff'; terminal
	"
	| c2i |
	c2i := [ :c | ('0123456789abcdef' indexOf: c asLowercase) - 1 ].
	^(self transforming: [ :in :out |
		out put: ((c2i value: in get) bitShift: 4) + (c2i value: in get) ])
		contentsSpecies: ByteString;
		yourself
