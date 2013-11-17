"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - interpreting
"
testWriteUnsignedShortEndianness

	(self output interpreting: #unsignedShort_le) put: 16rFF.
	(self output interpreting: #unsignedShort_be) put: 16rFF00.
	self output close.
	self assert: (self input read: 4) = #[ 16rFF 16r00 16rFF 00]
