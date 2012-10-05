initialize-release
initialize

	| dword |
	super initialize.
	dword := ExternalType unsignedLong.
	outputLength := ExternalData fromHandle: (ExternalAddress allocate: dword byteSize) type: dword.