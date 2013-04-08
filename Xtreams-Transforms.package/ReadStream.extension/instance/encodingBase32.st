"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
encodingBase32
	"Decodes characters of base-32 encoding into bytes. Ignores any intervening whitespace.
	Automatically ends the stream if it encounters final padding characters $=, or anything else that's not a valid encoding character."
	"	^<TransformReadStream>"
	"
		#('AE======' 'AEBA====' 'AEBAG===' 'AEBAGBA=' 'AEBAGBAFA') collect: [ :each | each reading encodingBase32 rest ]
	"
	| map cache |
	map := [ :char | ('ABCDEFGHIJKLMNOPQRSTUVWXYZ234567' indexOf: char) - 1 ].
	cache := ByteString new: 8.
	^(self transforming: [ :in :out || chars bits bytes i block nibble |
			chars := [ (in rejecting: #isSeparator) read: 8 into: cache at: 1 ] on: Incomplete do: [ :incomplete | incomplete count ].
			i := 1. bits := bytes := block := 0.
			[	i > chars or: [ (nibble := map value: (cache at: i)) negative ]
			] whileFalse: [ block :=  (block bitShift: 5) + nibble. bits := bits + 5. i := i + 1 ].
			[ bits > 7 ] whileTrue: [ bits := bits - 8. out put: ((block bitShift: bits negated) bitAnd: 255). bytes := bytes + 1 ]. 
			bytes < 5 ifTrue: [ (Incomplete count: bytes) raise ] ]
	)	buffer: (RingBuffer on: (ByteArray new: 5));
		yourself