private-hashes
BCryptFinishHash: hHash with: pbOutput with: cbOutput with: dwFlags
"	NTSTATUS BCryptFinishHash(
		BCRYPT_HASH_HANDLE hHash,
		PUCHAR pbOutput,
		ULONG cbOutput,
		ULONG dwFlags)
"	<cdecl: ulong 'BCryptFinishHash' (void* char* ulong ulong) module: 'bcrypt'>
	^self externalCallFailed