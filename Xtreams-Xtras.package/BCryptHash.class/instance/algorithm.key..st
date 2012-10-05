initialize-release
algorithm: id key: keyBytes
	
	id ifNotNil: [
		key := keyBytes.
		provider := library openAlgorithmProviderFor: id asUppercase flags: 8 "BCRYPT_ALG_HANDLE_HMAC_FLAG".
		objectLength := library getPropertyDWORD: 'ObjectLength' provider: provider.
		object := ExternalData fromHandle: (ExternalAddress allocate: objectLength) type: ExternalType unsignedChar ].
	handle := library createHashProvider: provider object: object length: objectLength key: key