private-ffi
HMAC_CTX_cleanup: ctx
	<cdecl: void 'HMAC_CTX_cleanup' (XTHMACCTX*) module: 'libcrypto'>
	^self externalCallFailed