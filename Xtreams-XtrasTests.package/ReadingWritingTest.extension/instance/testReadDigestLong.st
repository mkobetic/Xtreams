*Xtreams-XtrasTests-crypto
testReadDigestLong

	| content result hash in |
	content := ByteArray new: 32769.
	1 to: content size do: [:index | content at: index put: index \\ 256].
	hash := #[202 69 13 60 129 209 112 134 7 155 163 187 244 181 192 223 248 50 178 245].

	self	timeout: 1 seconds
		server:	[self output write: content. true]
		client:	[
			in := self input hashing: 'SHA1'.
			[result := in read: content size] ensure: [in close].
			in digest = hash and: [result = content]]