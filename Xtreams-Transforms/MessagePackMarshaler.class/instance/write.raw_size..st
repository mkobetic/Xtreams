"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: private - writing
"
write: writing raw_size: size
	size <= 2r00011111 ifTrue: [^writing uint8 put: size + 2r10100000].
	size <= 65535 ifTrue: [
		writing uint8 put: self class raw16.
		^writing uint16 put: size].
	size <= 4294967295 ifTrue: [
		writing uint8 put: self class raw32.
		^writing uint32 put: size].
	self error: 'array too big to marshal with MessagePack protocol'
