"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - writing
"
write: writing map_size: size
	size <= 2r00001111 ifTrue: [^writing uint8 put: size + 2r10000000].
	size <= 65535 ifTrue: [
		writing uint8 put: self class map16.
		^writing uint16 put: size].
	size <= 4294967295 ifTrue: [
		writing uint8 put: self class map32.
		^writing uint32 put: size].
	self error: 'array too big to marshal with MessagePack protocol'