private - ffi
EVP_DigestUpdate: ctx with: d with: cnt
	<cdecl: long 'EVP_DigestUpdate' (XTEVPMDCTX* void* long) module: 'libcrypto'>
	^self externalCallFailed