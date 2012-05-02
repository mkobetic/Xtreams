initialize-release
algorithm: id
	
	id ifNotNil: [algorithm := XTLibCrypto getDigestByName: id].
	self EVP_DigestInit_ex: context with: algorithm with: nil