"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - interpreting
"
testReadUnsignedShortEndianness

	self output write: #[ 16rFF 16r00 16rFF 00]; close.
	self assert: (self input interpreting: #unsignedShort_le) get = 16rFF.
	self assert: (self input interpreting: #unsignedShort_be) get = 16rFF00.
