private-general
BCryptCloseAlgorithmProvider: hAlgorithm with: dwFlags
"	NTSTATUS BCryptCloseAlgorithmProvider(
		BCRYPT_ALG_HANDLE hAlgorithm,
		ULONG dwFlags)
"	<cdecl: ulong 'BCryptCloseAlgorithmProvider' (void* ulong) module: 'bcrypt'>
	^self externalCallFailed