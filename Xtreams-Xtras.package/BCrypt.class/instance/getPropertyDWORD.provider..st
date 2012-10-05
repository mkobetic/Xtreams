api-general
getPropertyDWORD: aName provider: provider
	
	| status id dword output |
	id := self utf16CStringFrom: aName.
	dword := ExternalType unsignedLong.
	output := ExternalData fromHandle: (ExternalAddress allocate: dword byteSize) type: ExternalType unsignedChar.
	^[	(status := self
			BCryptGetProperty: provider
			with: id with: output with: dword byteSize
			with: outputLength with: 0
		) = 0 ifFalse: [self errorStatus: status].
		output getHandle unsignedLongAt: 1
	] ensure: [ output free ]