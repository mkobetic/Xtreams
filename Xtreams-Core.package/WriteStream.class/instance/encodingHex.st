"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
