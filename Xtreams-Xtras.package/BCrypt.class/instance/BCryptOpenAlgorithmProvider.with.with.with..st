private-general
BCryptOpenAlgorithmProvider: phAlgorithm with: pszAlgId with: pszImplementation with: dwFlags
"	NTSTATUS WINAPI BCryptOpenAlgorithmProvider(
	__out  BCRYPT_ALG_HANDLE *phAlgorithm,
	__in   LPCWSTR pszAlgId,
	__in   LPCWSTR pszImplementation,
	__in   DWORD dwFlags
	);
"	<cdecl: ulong 'BCryptOpenAlgorithmProvider' (void* char* char* ulong) module: 'bcrypt'>
	^self externalCallFailed