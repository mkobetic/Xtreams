api-hashes
createHashProvider: provider object: algorithm length: length key: key
	
	| output status voidPointer |
	voidPointer := ExternalType void asPointerType.
	output := ExternalData fromHandle: (ExternalAddress allocate: voidPointer byteSize) type: voidPointer.
	^[	(status := self BCryptCreateHash: provider
			with: output
			with: algorithm
			with: length
			with: key
			with: (key ifNil: [0] ifNotNil: [key size])
			with: 0
		) = 0 ifFalse: [self errorStatus: status].
		ExternalData fromHandle: (output getHandle pointerAt: 1) type: voidPointer
	] ensure: [ output free ]