*Xtreams-Xtras-transforming
hashing: id key: key
	"Computes an HMAC (message authentication code, i.e. keyed digest) of the bytes passing through. The underlying source stream must produce bytes (0..255). The final digest value can be obtained after the stream is closed using message #digest. The size of the digest depends on the hash algorithm, see DigestReadStream class comment for more details."
	"	id	<String>			name of the hashing algorithm to use, e.g. 'sha1', 'md5'
		key <ByteArray>		key is a random secret key of size up to HMAC_MAX_MD_CBLOCK (128)
		^	<DigestReadStream>
	""
		(Object comment reading
			hashing: 'sha1'
			key: (ByteArray withAll: (1 to: 50))
		) rest; close; digest
	"
	^(XTDigestReadStream on: self)
		algorithm: id key: key;
		yourself