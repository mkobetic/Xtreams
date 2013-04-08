"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
encodingBase32
	"Encodes bytes into characters of base-32 encoding.
	Emits final padding characters ($=) as required, when the stream is closed."
	"	^<TransformWriteStream>"
	"
		(1 to: 5) collect: [ :i | String new writing encodingBase32 write: (ByteArray withAll: (1 to: i)); conclusion ]
	"
	| map cache |
	map := [ :i | 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567' at: i + 1 ].
	cache := ByteArray new: 5.
	^(self transforming: [ :in :out || bytes chars bits block |
			bytes := [ in read: 5 into: cache at: 1 ] on: Incomplete do: [ :incomplete | incomplete count ].
			bytes isZero ifTrue: [ Incomplete zero raise ].
			block := (1 to: bytes) inject: 0 into: [ :total :byte | (total bitShift: 8) + (cache at: byte)].
			bits := bytes * 8.
			[ bits > 0 ] whileTrue: [ bits := bits - 5. out put: (map value: ((block bitShift: bits negated) bitAnd: 31)) ].
			chars := #[ 2 4 5 7 8 ] at: bytes.
			chars < 8 ifTrue: [
				8 - chars timesRepeat: [ out put: $= ].
				(Incomplete count: bytes) raise ] ]
	)	buffer: (RingBuffer on: (ByteArray new: 5));
		yourself