*Xtreams-Xtras-transforming
hashing: id
	"Computes a cryptographic hash (MD5, SHA, ...) of the bytes passing through. The underlying destination stream must be binary as well. The final digest value can be obtained after the stream is closed using message #digest. The size of the digest depends on the hash algorithm, see DigestWriteStream class comment for more details.
	""	id	<String>			name of the hashing algorithm to use, recognized by LibCrypto, e.g. 'sha512', 'md5', 'sha1'
		^	<DigestWriteStream>
	""
		(ByteArray new writing hashing: 'sha512') write: Object comment; close; digest
	"
	^(XTDigestWriteStream on: self)
		algorithm: id;
		yourself