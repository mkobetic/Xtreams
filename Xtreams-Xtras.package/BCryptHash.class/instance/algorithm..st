initialize-release
algorithm: id
	
	id ifNotNil: [
		provider := library openAlgorithmProviderFor: id asUppercase flags: 0.
		objectLength := library getPropertyDWORD: 'ObjectLength' provider: provider.
		object := ExternalData fromHandle: (ExternalAddress allocate: objectLength) type: ExternalType unsignedChar asPointerType ].
	handle := library createHashProvider: provider object: object length: objectLength key: nil