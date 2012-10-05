private-ffi
HMAC_Final: ctx with: md with: len
	<cdecl: long 'HMAC_Final' (XTHMACCTX* char* long*) module: 'libcrypto'>
	^self externalCallFailed