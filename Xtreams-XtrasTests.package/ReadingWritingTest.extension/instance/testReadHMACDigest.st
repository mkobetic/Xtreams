*Xtreams-XtrasTests-crypto
testReadHMACDigest

	| content result hash in key |
	content := ByteArray withAll: (1 to: 200).
	key := ByteArray withAll: (1 to: 50).
	hash := #[150 200 234 170 46 39 176 69 56 77 242 24 192 159 25 188 216 212 251 50].
	self output write: content.
	in := self input hashing: 'SHA1' key: key.
	[	result := in read: content size
	] ensure: [ in close ].
	self assert: in digest = hash.
	self assert: result = content.