*Xtreams-XtrasTests-crypto
testReadDigest

	| content result hash in |
	content := ByteArray withAll: (1 to: 200).
	hash := #[191 214 97 229 242 76 110 243 144 172 143 238 163 155 96 32 128 47 232 63].
	self output write: content.
	in := self input hashing: 'SHA1'.
	[	result := in read: content size
	] ensure: [ in close ].
	self assert: in digest = hash.
	self assert: result = content.