private-hashes
BCryptHashData: hHash with: pbInput with: cbInput with: dwFlags
"	NTSTATUS BCryptHashData(
		BCRYPT_HASH_HANDLE hHash,
		PUCHAR pbInput,
		ULONG cbInput,
		ULONG dwFlags)
"	<cdecl: ulong 'BCryptHashData' (void* char* ulong ulong) module: 'bcrypt'>
	^self externalCallFailed