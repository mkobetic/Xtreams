*Xtreams-XtrasTests-crypto
testWriteDigest

	| content result out hash |
	content := ByteArray withAll: (1 to: 200).
	hash :=  #[191 214 97 229 242 76 110 243 144 172 143 238 163 155 96 32 128 47 232 63].
	out := self output hashing: 'SHA1'.
	[ out write: content ] ensure: [ out close ].
	self assert: out digest = hash.
	result := self input read: 200.
	self assert: result = content.