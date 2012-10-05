api-general
openAlgorithmProviderFor: aName flags: flags

	| id voidPointer output status |
	id := self utf16CStringFrom: aName.
	voidPointer := ExternalType void asPointerType.
	output := ExternalData fromHandle: (ExternalAddress allocate: voidPointer byteSize) type: voidPointer.
	^[	(status := self BCryptOpenAlgorithmProvider: output with: id with: nil with: flags) = 0
			ifFalse: [ self errorStatus: status ].
		ExternalData fromHandle: (output getHandle pointerAt: 1) type: voidPointer
	] ensure: [ output free ]