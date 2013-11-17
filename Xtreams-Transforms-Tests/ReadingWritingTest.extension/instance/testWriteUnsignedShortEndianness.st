"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - interpreting
"
testWriteUnsignedShortEndianness

	(self output interpreting: #unsignedShort_le) put: 16rFF.
	(self output interpreting: #unsignedShort_be) put: 16rFF00.
	self output close.
	self assert: (self input read: 4) = #[ 16rFF 16r00 16rFF 00]
