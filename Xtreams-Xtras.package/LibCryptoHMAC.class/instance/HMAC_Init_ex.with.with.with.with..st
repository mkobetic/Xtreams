private-ffi
HMAC_Init_ex: ctx with: key with: key_len with: md with: impl
	<cdecl: long 'HMAC_Init_ex' (XTHMACCTX* void* long XTEVPMD* void*) module: 'libcrypto'>
	^self externalCallFailed