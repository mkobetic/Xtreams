*Xtreams-Xtras-transforming
hashing: id key: key
	"Computes an HMAC (message authentication code, i.e. keyed digest) of the bytes passing through. The underlying destination stream must be binary as well. The final digest value can be obtained after the stream is closed using message #digest. The size of the digest depends on the hash algorithm, see DigestWriteStream class comment for more details.
	""	id	<String>			name of the hashing algorithm to use, e.g. 'sha512', 'md5', 'sha1'
		key <ByteArray>		key is a random secret key of size up to HMAC_MAX_MD_CBLOCK (128)
		^	<DigestWriteStream>
	""
		(ByteArray new writing
			hashing: 'sha512'
			key: (ByteArray withAll: (1 to: 50))
		) write: Object comment; close; digest
	"
	^(XTDigestWriteStream on: self)
		algorithm: id key: key;
		yourself