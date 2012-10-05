private-general
BCryptGetProperty: hObject with: pszProperty with: pbOutput with: cbOutput with: pcbResult with: dwFlags
"	NTSTATUS BCryptGetProperty(
		BCRYPT_HANDLE hObject,
		LPCWSTR pszProperty,
		PUCHAR pbOutput,
		ULONG cbOutput,
		ULONG *pcbResult,
		ULONG dwFlags)
"	<cdecl: ulong 'BCryptGetProperty' (void* char* char* ulong ulong* ulong) module: 'bcrypt'>
	^self externalCallFailed