"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: transforming
"
encodingBase64
	"Encodes bytes into characters of base-64 encoding.
	Emits final padding characters ($=) as required, when the stream is closed."
	"	^<TransformWriteStream>"
	"
		String new writing encodingBase64 write: (ByteArray withAll: (1 to: 20)); conclusion
	"
	| map cache |
	map := [ :i | 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' at: i + 1 ].
	cache := ByteArray new: 3.
	^(self transforming: [ :in :out | | count block shift |
		count := [ in read: 3 into: cache at: 1. 3 ] on: Incomplete do: [ :incomplete | incomplete count].
		count isZero ifTrue: [ Incomplete zero raise ].
		block := (1 to: count) inject: 0 into: [ :total :byte | (total bitShift: 8) + (cache at: byte)].
		shift := count * -8.
		1 to: count + 1 do: [:i | out put: (map value: ((block bitShift: (shift + (i * 6))) bitAnd: 63))].
		count < 3 ifTrue: [
			3 - count timesRepeat: [ out put: $= ].
			(Incomplete count: count) raise]])
		buffer: (RingBuffer on: (ByteArray new: 3));
		yourself
