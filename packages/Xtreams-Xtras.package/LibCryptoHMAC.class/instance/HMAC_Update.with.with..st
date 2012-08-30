private-ffi
HMAC_Update: ctx with: data with: len
	<cdecl: long 'HMAC_Update' (XTHMACCTX* char* long) module: 'libcrypto'>
	^self externalCallFailed