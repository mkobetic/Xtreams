Computes a cryptographic hash (MD5, SHA, ...) of the contents while passing the bytes through. The stream uses a suitable subclass of Hash as the implementation of the algorithm. Currently there are implementations using Windows bcrypt.dll (Vista and later) or OpenSSL's libcrypto.so on all other platforms. The underlying source stream must produce bytes (0..255). The final digest value can be obtained after the stream is closed using message #digest. The size of the digest depends on the hash algorithm.

The set of supported algorithms depends on the underlying implementation. Commonly available algorithms are MD5, SHA1, SHA256 and SHA512. Main difference is the size of the  resulting digest. Larger digest generally means stronger algorithm.

Digest streams also support the keyed HMAC algorithm. It combines a hash algorithm with secret random key. It is used for data integrity protection, in some respects it is similar to a digital signature. The API is identical to regular digest streams, except the additional #key: parameter when the stream is created.

Instance Variables
	input	<ByteArray> fixed-space input buffer shared with libCrypto
	digest	<ByteArray> caches the final digest value computed when the stream is closed
	hash	<Hash> implementation of the hash algorithm

