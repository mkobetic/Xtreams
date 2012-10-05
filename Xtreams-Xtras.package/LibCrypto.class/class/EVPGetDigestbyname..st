private-ffi
EVPGetDigestbyname: id
	<cdecl: XTEVPMD* 'EVP_get_digestbyname' (char*) module: 'libcrypto'>
	^self externalCallFailed