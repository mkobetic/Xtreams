*Xtreams-XtrasTests-crypto
testWriteHMACDigest

	| content result out hash key |
	content := ByteArray withAll: (1 to: 200).
	key := ByteArray withAll: (1 to: 50).
	hash := #[150 200 234 170 46 39 176 69 56 77 242 24 192 159 25 188 216 212 251 50].
	out := self output hashing: 'SHA1' key: key.
	[ out write: content ] ensure: [ out close ].
	self assert: out digest = hash.
	result := self input read: 200.
	self assert: result = content.