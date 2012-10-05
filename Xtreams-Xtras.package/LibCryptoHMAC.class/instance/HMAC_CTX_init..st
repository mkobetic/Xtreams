private-ffi
HMAC_CTX_init: ctx
	<cdecl: long 'HMAC_CTX_init' (XTHMACCTX*) module: 'libcrypto'>
	^self externalCallFailed