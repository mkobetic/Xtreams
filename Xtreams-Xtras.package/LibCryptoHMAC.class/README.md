Implements HMAC by calling OpenSSL libcrypto HMAC APIs.

Instance Variables
	library	<LibCryptoEVP> external interface to libCrypto
	context	<CPointer> pointer to libCrypto's context structure
	algorithm	<CPointer> pointer to libCrypto's digest definition structure (constant)

