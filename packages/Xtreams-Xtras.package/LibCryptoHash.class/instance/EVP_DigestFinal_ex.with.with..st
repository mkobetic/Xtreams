private - ffi
EVP_DigestFinal_ex: ctx with: md with: s
	<cdecl: long 'EVP_DigestFinal_ex' (XTEVPMDCTX* char* ulong*) module: 'libcrypto'>
	^self externalCallFailed