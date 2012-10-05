Implements Hash by calling OpenSSL libcrypto EVP APIs. The list of possible names can be obtained via 'openssl speed help' command. Following table mentions some of the algorithms supported by OpenSSL 1.0.0-fips-beta4:

	||	id		||	algorithm		||	notes
	||	md2		||	MD2			||	weak (use for compatibility only)
	||	md4		||	MD4			||	weak (use for compatibility only)
	||	md5		||	MD5			||	MD5 (128-bit digest)
	||	sha1	||	SHA-1			||	SHA-1 (160-bit digest)
	||	sha256	||	SHA-256		||	SHA-2 with 256-bit digest
	||	sha512	||	SHA-512		||	SHA-2 with 512-bit digest
	||	rmd160	||	RIPEMD-160	||

Instance Variables
	library	<LibCryptoEVP> external interface to libCrypto
	context	<CPointer> pointer to libCrypto's context structure
	algorithm	<CPointer> pointer to libCrypto's digest definition structure (constant)

