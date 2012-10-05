*Xtreams-Xtras-transforming
hashing: id
	"Computes a cryptographic hash (MD5, SHA, ...) of the bytes passing through. The underlying source stream must produce bytes (0..255). The final digest value can be obtained after the stream is closed using message #digest. The size of the digest depends on the hash algorithm, see DigestReadStream class comment for more details."
	"	id	<String>			name of the hashing algorithm to use, recognized by LibCrypto, e.g. 'sha512', 'md5', 'sha1'
		^	<DigestReadStream>
	""
		(Object comment reading hashing: 'sha512') rest; close; digest
	"
	^(XTDigestReadStream on: self)
		algorithm: id;
		yourself