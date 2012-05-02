initialize-release
algorithm: id key: key
	
	id ifNotNil: [algorithm := XTLibCrypto getDigestByName: id].
	self
		HMAC_Init_ex: context
		with: key
		with: ((key ifNil: [0] ifNotNil: [ key size ]) min: self HMAC_MAX_MD_CBLOCK)
		with: algorithm
		with: nil