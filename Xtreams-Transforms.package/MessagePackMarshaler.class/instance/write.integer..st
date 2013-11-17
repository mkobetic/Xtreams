"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - writing
"
write: writing integer: integer
	(integer between: 0 and: 127) ifTrue: [^writing uint8 put: integer].
	(integer between: -32 and: -1) ifTrue: [^writing uint8 put: integer + 256].
	integer >= 128 ifTrue: [
		integer <= 255 ifTrue: [^writing uint8 put: self class uint8; put: integer].
		integer <= 65535 ifTrue: [
			writing uint8 put: self class uint16.
			^writing uint16 put: integer].
		integer <= 4294967295 ifTrue: [
			writing uint8 put: self class uint32.
			^writing uint32 put: integer].
		integer <= 18446744073709551615 ifTrue: [
			writing uint8 put: self class uint64.
			^writing uint64 put: integer].
		self error: 'integer too big to marshal with MessagePack protocol'].
	integer >= -128 ifTrue: [
		writing uint8 put: self class int8.
		^writing int8 put: integer].
	integer >= -32768 ifTrue: [
		writing uint8 put: self class int16.
		^writing int16 put: integer].
	integer >= -2147483648 ifTrue: [
		writing uint8 put: self class int32.
		^writing int32 put: integer].
	integer >= -9223372036854775808 ifTrue: [
		writing uint8 put: self class int64.
		^writing int64 put: integer].
	self error: 'integer too small to marshal with MessagePack protocol'.
